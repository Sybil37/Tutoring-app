class TutorsController < ApplicationController
    def index
        @tutor = Tutor.all

    end

    def show
        @tutor = Tutor.find(params[:id])
    end

    def edit 
        @tutor = Tutor.find(params[:id]) 
    end

    def update 
        @tutor = Tutor.find(params[:id]) 
        if @tutor.update_attributes(tutor_params) 
          redirect_to(:action => 'show', :id => @tutor.id) 
        else 
          render 'edit' 
        end 
    end

    def new 
        @tutor = Tutor.new

    end

    def create
        @tutor = Tutor.new(tutor_params)
        if @tutor.save
            redirect_to "/tutors/#{@tutor.id}"
        else
            render 'new'
        end

    end
private
    def tutor_params
        params.require(:tutor).permit(:name, :subject, :picture, :education)

    end

end