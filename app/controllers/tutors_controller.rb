class TutorsController < ApplicationController
    def index


    end

    def show
        @tutor = Tutor.find(params[:id])
    end
    def new 
        @tutor = Tutor.new

    end

    def create
        @tutor = Tutor.new(tutor_params)
        if @tutor.save
            redirect_to "/show/#{@tutor.id}"
        else
            render 'new'
        end

    end
private
    def tutor_params
        params.require(:tutor).permit(:name, :subject, :picture)

    end

end