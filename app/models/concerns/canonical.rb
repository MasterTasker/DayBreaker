module Canonical

  module UUID

    def coerce_uuid_field(field_name)
      before_validation do |record|
        record.send(:"#{field_name}=", nil) if record.send(field_name).blank?
      end
    end

    def autobuild_uuid_field(field_name)
      if columns.find { |column| column.name == field_name.to_s }
        after_initialize do |record|
          record.send(:"#{field_name}=", ::UUID.new.generate) unless record.send(field_name)
        end
      end
    end


    class << self

      def extended base
        # Coerce all UUID fields
        base.columns.select do |column|
          column.type == :uuid
        end.map(&:name).each do |name|
          base.coerce_uuid_field name
        end
        # Always autobuild pk
        base.autobuild_uuid_field base.primary_key
      end

    end

  end

end
