module API
  module V1
    class Artists < Grape::API
      include API::V1::Defaults

      resource :artists do
        desc "Create an artist"
        params do
          requires :name, type: String, desc: "Name of the artist"
          optional :bio, type: String, desc: "Biography of the artist"
        end
        post "", root: :artists do
          Artist.create!(permitted_params)
        end

        desc "Get artists list"
        get "", root: :artist do
          Artist.all
        end

        desc "Get an artist by id"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
        end
        get ":id", root: :artist do
          Artist.find(permitted_params[:id])
        end

        desc "Delete an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
        end
        delete ":id", root: :artists do
          Artist.find(permitted_params[:id]).destroy
        end

        desc "Update an artist"
        params do
          optional :name, type: String, desc: "Name of the artist"
          optional :bio, type: String, desc: "Biography of the artist"
        end
        put ":id", root: :artists do
          Artist.find(permitted_params[:id]).update!(permitted_params)
        end
      end
    end
  end
end
