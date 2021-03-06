class HabitacionesController < ApplicationController
  def index
      @habitaciones = Habitacion.using(:dwh_t).where(error: true)
  end

  def edit
    @habitaciones = Habitacion.using(:dwh_t).find(params[:id])
    end

  def destroy
    @habitaciones = Habitacion.using(:dwh_t).find(params[:id])
    if @habitaciones.destroy
      flash[:notice] = 'Eliminado'
    else
      flash[:alert] = 'Error eliminando'
    end
    redirect_to habitaciones_path
  end

  def update
    @habitaciones = Habitacion.using(:dwh_t).find(params[:id])
    if validate_attributes && @habitaciones.update(habitaciones_params)
      @habitaciones.update_attributes(error: false)
      flash[:notice] = 'Actualizado Correctamente'
      redirect_to habitaciones_path
    else
      flash.now[:alert] = 'Error actualizando'
      render 'edit'
    end
  end

  def delete_with_errors_habitaciones
    Habitacion.using(:dwh_t).where(error: true).delete_all
    redirect_to landing_page_index_path
  end 

  def habitaciones_params
    params.require(:habitacion).permit(:id, :tipo_habitacion, :estado)
  end

  def validate_attributes
    valid_activah?(params[:habitacion][:estado])
  end
end
