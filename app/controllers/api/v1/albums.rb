module API
  module V1
    class Albums < Grape::API
      include API::V1::Defaults

      resource :albums do
        before do
          @album = Album.find(params[:id]) if params[:id]
        end

        desc 'Get albums list'
        get do
          Album.all
        end

        desc 'Get an album'
        params do
          requires :id, type: Integer, desc: "ID of the album"
        end
        get ':id' do
          @album
        end

        desc "Create an album"
        params do
          requires :name, type: String, desc: "Name of the album"
        end
        post do
          Album.create!(permitted_params)
        end

        desc "Delete an album"
        params do
          requires :id, type: Integer, desc: "ID of the album"
        end
        delete ":id" do
          @album.destroy!
        end

        desc "Update an album"
        params do
          requires :id, type: Integer, desc: "ID of the album"
          optional :name, type: String, desc: "Name of the album"
        end
        put ":id" do
          @album.update!(permitted_params)
        end

        desc "Add a song to an album"
        params do
          requires :id, type: Integer, desc: "ID of the album"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/add_song" do
          @album.songs << Song.find(permitted_params[:song_id])
          @album.save!
        end

        desc "Remove a song from an album"
        params do
          requires :id, type: Integer, desc: "ID of the album"
          requires :song_id, type: Integer, desc: "ID of the song"
        end
        put ":id/remove_song" do
          @album.songs.delete(Song.find(permitted_params[:song_id]))
          @album.save!
        end
      end
    end
  end
end
