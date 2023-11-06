module Tasks
  class Create
    include Interactor::Organizer

    delegate :task, :project, to: :context

    organize Tasks::Creates::PrepareParams,
             Tasks::Save

    after do
      TaskMailer.task_created(task, project).deliver_later
    end
  end
end
