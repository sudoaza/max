module API
  module V1
    class Playlists < Grape::API
      include API::V1::Defaults

      resource :playlists do
        before do
          @playlist = Playlist.find(params[:id]) if params[:id]
        end

        desc "Create a playlist"
        params do
          requires :name, type: String, desc: "Name of the playlist"
        end
        post do
          Playlist.create!(permitted_params)
        end

        desc 'Get the playlists list'
        get do
          Playlist.all
        end

        desc 'Get a playlist'
        params do
          requires :id, type: Integer, desc: 'ID of the playlist'
        end
        get ':id' do
          @playlist
        end

        desc "Delete a playlist"
        params do
          requires :id, type: Integer, desc: "ID of the playlist"
        end
        delete ":id" do
          @playlist.destroy!
        end

        desc "Update a playlist"
        params do
          optional :name, type: String, desc: "Name of the playlist"
        end
        put ":id" do
          @playlist.update!(permitted_params)
        end

        desc "Add a song to a playlist"
        params do
          requires :id, type: Integer, desc: "ID of the playlist"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/add_song" do
          @playlist.songs << Song.find(permitted_params[:song_id])
          @playlist.save!
        end

        desc "Remove a song from an playlist"
        params do
          requires :id, type: Integer, desc: "ID of the playlist"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/remove_song" do
          @playlist.songs.delete(Song.find(permitted_params[:song_id]))
          @playlist.save!
        end
      end
    end
  end
end
