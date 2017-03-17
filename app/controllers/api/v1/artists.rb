module API
  module V1
    class Artists < Grape::API
      include API::V1::Defaults

      resource :artists do
        before do
          @artist = Artist.find(params[:id]) if params[:id]
        end

        desc "Create an artist"
        params do
          requires :name, type: String, desc: "Name of the artist"
          optional :bio, type: String, desc: "Biography of the artist"
        end
        post "", root: :artists do
          Artist.create!(permitted_params)
        end

        desc "Get artists list"
        get "", root: :artists do
          Artist.all
        end

        desc "Get an artist by id"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
        end
        get ":id", root: :artists do
          @artist
        end

        desc "Delete an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
        end
        delete ":id", root: :artists do
          @artist.destroy!
        end

        desc "Update an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          optional :name, type: String, desc: "Name of the artist"
          optional :bio, type: String, desc: "Biography of the artist"
        end
        put ":id", root: :artists do
          @artist.update!(permitted_params)
        end

        desc "Add a song to an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/add_song", root: :artists do
          @artist.songs << Song.find(permitted_params[:song_id])
          @artist.save!
        end

        desc "Remove a song from an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/remove_song", root: :artists do
          @artist.songs.delete(Song.find(permitted_params[:song_id]))
          @artist.save!
        end

        desc "Add an album to an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          requires :album_id, type: Integer, desc: "ID of the album"
        end
        put ":id/add_album", root: :artists do
          @artist.albums << Album.find(permitted_params[:album_id])
          @artist.save!
        end

        desc "Remove an album from an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          requires :album_id, type: Integer, desc: "ID of the album"
        end
        put ":id/remove_album", root: :artists do
          @artist.albums.delete(Album.find(permitted_params[:album_id]))
          @artist.save!
        end
      end
    end
  end
end
