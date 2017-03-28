module API
  module V1
    class Songs < Grape::API
      include API::V1::Defaults

      resource :songs do
        before do
          @song = Song.find(params[:id]) if params[:id]
        end

        desc 'Create a song'
        params do
          requires :name, type: String, desc: "Name of the song"
          requires :duration, type: Integer, desc: "Duration of the song"
          optional :featured_attributes, type: Hash do
            requires :art_id, type: Integer, desc: "ID of the Art for the featured song"
            optional :history, type: String, desc: "History for the featured song"
          end
        end
        post do
          Song.create!(permitted_params)
        end

        desc 'Get a song'
        params do
          requires :id, type: Integer, desc: 'ID of the song'
        end
        get ':id' do
          @song
        end

        desc 'Delete a song'
        params do
          requires :id, type: Integer, desc: "ID of the song"
        end
        delete ":id" do
          @song.destroy
        end

        desc "Update an song"
        params do
          requires :id, type: Integer, desc: "ID of the song"
          optional :name, type: String, desc: "Name of the song"
          optional :duration, type: Integer, desc: "Duration of the song"
          optional :featured_attributes, type: Hash do
            optional :art_id, type: Integer, desc: "ID of the Art for the featured song"
            optional :history, type: String, desc: "History for the featured song"
          end
        end
        put ":id" do
          @song.update!(permitted_params)
        end
      end
    end
  end
end
