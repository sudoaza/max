module API
  module V1
    class Genres < Grape::API
      include API::V1::Defaults

      resource :genres do
        desc "List genres"
        get do
          Genre.all
        end
      end
    end
  end
end
