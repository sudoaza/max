module API
  module V1
    class Artists < Grape::API
      include API::V1::Defaults

      resource :artists do
        desc "Create an artist"
        post "", root: :artists do
          Artist.create(permitted_params)
        end

        desc "Delete an artist"
        params do
          requires :id, type: Integer, desc: "ID of the artist"
        end
        delete ":id", root: :artists do
          Artist.find(permitted_params[:id]).destroy
        end

        desc "Update an artist"
        put ":id", root: :artists do
          Artist.find(permitted_params[:id]).update(permitted_params)
        end
      end
    end
  end
end
