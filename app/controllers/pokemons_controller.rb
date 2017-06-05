class PokemonsController < ApplicationController
    
    before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
    before_action :check_minimum, only: [:index]

    def index
        flash[:success] = "Ce message va s'afficher sur la liste des Pokemons"
        @pokemons = Pokemon.paginate(page: params[:page], per_page: 1).includes(:type, :moves)
    end

    def show
    end

    def new
        @pokemon = Pokemon.new
    end

    def create
        @pokemon = Pokemon.new pokemon_params
        if @pokemon.save
            redirect_to @pokemon
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @pokemon.update pokemon_params
            redirect_to @pokemon
        else
            render 'edit'
        end
    end

    def destroy
        @pokemon.destroy
        redirect_to @pokemon
    end

    private

    def pokemon_params
        params.require(:pokemon).permit(
            :name,
            :number,
            :level,
            :health_points,
            :avatar,
            :type_id,
            move_ids: []
        )
    end

    def set_pokemon
        @pokemon = Pokemon.find params[:id]
    end

    def check_minimum
        count = Pokemon.count
        limit = 5
        flash[:danger] = "Attention, il y a moins de #{limit} Pokemons !" if count < 5
    end
end