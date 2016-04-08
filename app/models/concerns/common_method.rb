## Module that contains all the common methods that can be shared through all class

module CommonMethod
  extend ActiveSupport::Concern

  module ClassMethods
    # Search and paginate
    def search_and_paginate(params)
      filter_search(params).paginate(page: params[:page], per_page: 50)
    end

    def filter_search(attributes)
      attributes.inject(self) do |scope, (key, value)|
        # return scope.scoped if value.blank?
        if value.blank?
          scope.all
        else
          case key.to_sym

          when :order # order=field-(ASC|DESC)
            attribute, order = value.split('-')
            scope.order("#{table_name}.#{attribute} #{order}")
          else # unknown key (do nothing or raise error, as you prefer to)
            scope.all
          end

        end
      end
    end
  end
end
