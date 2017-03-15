module API
  module V1
    class Playlists < Grape::API
      include API::V1::Defaults

      resource :playlists do
        desc "Create a playlist"
        post "", root: :playlists do
          Playlist.create(permitted_params)
        end

        desc "Delete a playlist"
        params do
          requires :id, type: Integer, desc: "ID of the playlist"
        end
        delete ":id", root: :playlists do
          Playlist.find(permitted_params[:id]).destroy
        end

        desc "Update a playlist"
        put ":id", root: :playlists do
          Playlist.find(permitted_params[:id]).update(permitted_params)
        end

        desc "Add a song to a playlist"
        put ":id/add_song", root: :playlists do
          Playlist.find(permitted_params[:id]).songs <<
              Song.find(permitted_params[:song_id])
        end

        desc "Remove a song from an playlist"
        put ":id/remove_song", root: :playlists do
          Playlist.find(permitted_params[:id]).songs.delete(
              Song.find(permitted_params[:song_id]))
        end
      end
    end
  end
end
