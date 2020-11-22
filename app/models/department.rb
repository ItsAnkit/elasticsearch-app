class Department < ApplicationRecord
    has_many :employees

    after_save :index_employees_elasticsearch

    def index_employees_elasticsearch
        employees.find_each { |emp| emp.__elasticsearch__.index_document }
    end

end
