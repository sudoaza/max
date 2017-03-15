module API
  module V1
    class Albums < Grape::API
      include API::V1::Defaults

      resource :albums do
        desc "Create an album"
        post "", root: :albums do
          Album.create(permitted_params)
        end

        desc "Delete an album"
        params do
          requires :id, type: Integer, desc: "ID of the album"
        end
        delete ":id", root: :albums do
          Album.find(permitted_params[:id]).destroy
        end

        desc "Update an album"
        put ":id", root: :albums do
          Album.find(permitted_params[:id]).update(permitted_params)
        end

        desc "Add a song to an album"
        put ":id/add_song", root: :albums do
          Album.find(permitted_params[:id]).songs <<
              Song.find(permitted_params[:song_id])
        end

        desc "Remove a song from an album"
        put ":id/remove_song", root: :albums do
          Album.find(permitted_params[:id]).songs.delete(
              Song.find(permitted_params[:song_id]))
        end
      end
    end
  end
end
