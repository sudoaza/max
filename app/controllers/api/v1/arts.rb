module API
  module V1
    class Arts < Grape::API
      include API::V1::Defaults

      helpers do
        def must_have_image!
          throw :error, message: "Must have image", status: 422 unless permitted_params.image
        end
      end

      resource :arts do

        desc "Upload new art"
        params do
          requires :image, type: File, desc: "Image file."
        end
        post do
          must_have_image!
          Art.create! image: ActionDispatch::Http::UploadedFile.new(permitted_params.image)
        end

        desc "Get art by id or fingerprint"
        params do
          optional :id_or_fingerprint, type: String,
              desc: "ID of the art or MD5 fingerprint of the image file"
        end
        get ':id_or_fingerprint' do
          Art.by_id_or_fingerprint(permitted_params[:id_or_fingerprint]).first!
        end

      end

    end
  end
end
