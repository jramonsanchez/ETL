class EmpresasController < ApplicationController
  def index
    @empresas = Empresa.using(:dwh_t).where(error: true)
  end

  def edit
    @empresa = Empresa.using(:dwh_t).find(params[:id])
  end

  def update
    @empresa = Empresa.using(:dwh_t).find(params[:id])

    if @empresa.update(empresa_attributes)
      flash[:notice] = 'Actualizado'
      redirect_to empresas_path
    else
      flash.now[:alert] = 'Error actualizando'
      render 'edit'
    end
  end

  private

  def empresa_attributes
    params.require(:empresa).permit(:nombre)
  end
end
