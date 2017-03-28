module API
  module V1
    class Base < Grape::API
      mount API::V1::Artists
      mount API::V1::Albums
      mount API::V1::Songs
      mount API::V1::Playlists
      mount API::V1::Arts
    end
  end
end
