module API
  module V1
    class Playlists < Grape::API
      include API::V1::Defaults

      resource :playlists do
        desc "Create a playlist"
        params do
          requires :name, type: String, desc: "Name of the playlist"
        end
        post "", root: :playlists do
          Playlist.create!(permitted_params)
        end

        desc "Delete a playlist"
        params do
          requires :id, type: Integer, desc: "ID of the playlist"
        end
        delete ":id", root: :playlists do
          Playlist.find(permitted_params[:id]).destroy
        end

        desc "Update a playlist"
        params do
          optional :name, type: String, desc: "Name of the playlist"
        end
        put ":id", root: :playlists do
          Playlist.find(permitted_params[:id]).update!(permitted_params)
        end

        desc "Add a song to a playlist"
        params do
          requires :id, type: Integer, desc: "ID of the playlist"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/add_song", root: :playlists do
          Playlist.find(permitted_params[:id]).songs <<
              Song.find(permitted_params[:song_id])
        end

        desc "Remove a song from an playlist"
        params do
          requires :id, type: Integer, desc: "ID of the playlist"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/remove_song", root: :playlists do
          Playlist.find(permitted_params[:id]).songs.delete(
              Song.find(permitted_params[:song_id]))
        end
      end
    end
  end
end
