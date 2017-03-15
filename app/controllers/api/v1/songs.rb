module API
  module V1
    class Songs < Grape::API
      include API::V1::Defaults

      resource :songs do
        desc "Create a song"
        params do
          requires :name, type: String, desc: "Name of the song"
        end
        post "", root: :songs do
          Song.create!(permitted_params)
        end

        desc "Delete a song"
        params do
          requires :id, type: Integer, desc: "ID of the song"
        end
        delete ":id", root: :songs do
          Song.find(permitted_params[:id]).destroy
        end

        desc "Update an song"
        params do
          requires :id, type: Integer, desc: "ID of the song"
          optional :name, type: String, desc: "Name of the song"
        end
        put ":id", root: :songs do
          Song.find(permitted_params[:id]).update!(permitted_params)
        end
      end
    end
  end
end
