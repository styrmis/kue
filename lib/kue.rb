require "kue/version"

module Kue
  module Store
    def self.included(base)
      base.send :extend, ClassMethods
      base.send :set_table_name, :kue_settings
      base.send :set_primary_key, :key
    end
  
    module ClassMethods         
      def keys
        KueStore.all.map(&:key).map(&:to_sym)
      end
  
      def [](key)
        begin
          entry = KueStore.find(key)
          YAML.load(entry.value)
        rescue ActiveRecord::RecordNotFound
          return nil
        end
      end
       
      def []=(key, value)
        setting = KueStore.find_or_create_by_key(key)
        setting.value = value.to_yaml
        setting.save!
      end
  
      def delete!(key)
        begin
          entry = KueStore.find(key)
          entry.destroy
        rescue ActiveRecord::RecordNotFound
          return false
        end
      end
  
      def exists?(key)
        !self[key].nil?
      end
      
      def clear!
        KueStore.destroy_all
      end
    end
  end
end

class KueStore < ActiveRecord::Base
  include Kue::Store
end
