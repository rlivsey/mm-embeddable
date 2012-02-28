require 'mongo_mapper'

module MongoMapper
  module Plugins
    module Embeddable
      extend ActiveSupport::Concern

      class EmbeddableDocument #:nodoc:
        include ::MongoMapper::EmbeddedDocument

        class << self
          attr_writer :full_class
        end

        def self.from_full(full_document)
          self.new.tap do |d|
            (full_class.embeddable_keys + [:_id]).each do |k|
              d.send("#{k}=".to_sym, full_document.send(k.to_sym))
            end
          end
        end

        def self.full_class
          @full_class or raise NotImplementedError, 'This embed has no full class.'
        end

        def original_object
          return @_original_object if defined?(@_original_object)
          @_original_object = self.class.full_class.find(self.id)
        end

        def method_missing(*args)
          original_object.send(*args)
        end

        def self.to_mongo(instance)
          return unless instance
          case instance
          when full_class
            from_full(instance).to_mongo
          else
            instance.to_mongo
          end
        end
      end

      module ClassMethods
        # Tells MongoMapper that this document can be embedded. Pass
        # in an array of the keys that should be persisted to the
        # embedded document (<tt>_id</tt> is automatically persisted
        # as a reference to the full document).
        def embeds(*ckeys)
          embeddable_keys.push(*ckeys)

          self.const_set(:Embeddable, Class.new(::MongoMapper::Plugins::Embeddable::EmbeddableDocument))

          self.const_get(:Embeddable).full_class = self
          self.const_get(:Embeddable).key :_id, ObjectId

          ckeys.each do |k|
            self.const_get(:Embeddable).key k
            self.const_get(:Embeddable).keys[k.to_s] = self.keys[k.to_s].dup
          end
        end

        def embeddable_keys
          @embeddable_keys ||= []
        end
      end

      def to_embeddable
        self.class.const_get(:Embeddable).from_full(self)
      end
    end
  end
end

MongoMapper::Document.plugin(MongoMapper::Plugins::Embeddable)