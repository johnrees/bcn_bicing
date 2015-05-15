namespace :importer do

  %w(start stop).each do |task_name|
    desc "#{task_name} Importer"
    task task_name do
      on roles(:app), in: :sequence, wait: 5 do
        sudo "service importer #{task_name}"
      end
    end
  end

end
