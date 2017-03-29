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
        post do
          Artist.create!(permitted_params)
        end

        desc "Get artists list"
        get do
          Artist.all
        end

        desc "Get an artist by id"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
        end
        get ":id" do
          @artist
        end

        desc "Delete an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
        end
        delete ":id" do
          @artist.destroy!
        end

        desc "Update an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          optional :name, type: String, desc: "Name of the artist"
          optional :bio, type: String, desc: "Biography of the artist"
        end
        put ":id" do
          @artist.update!(permitted_params)
        end

        desc "Add an album to an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          requires :album_id, type: Integer, desc: "ID of the album"
        end
        put ":id/add_album" do
          @artist.albums << Album.find(permitted_params[:album_id])
          @artist.save!
        end

        desc "Remove an album from an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
          requires :album_id, type: Integer, desc: "ID of the album"
        end
        put ":id/remove_album" do
          @artist.albums.delete(Album.find(permitted_params[:album_id]))
          @artist.save!
        end
      end
    end
  end
end
