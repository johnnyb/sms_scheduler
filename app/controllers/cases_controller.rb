# encoding: utf-8
class CasesController < ApplicationController
	def index
		redirect_to case_path(params[:case_number]) if params[:case_number].present?
	end

	def show
		@oscn_case = OscnCase.new(params[:id])
		@oscn_case.load!
	end
end
