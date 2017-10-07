def report_error(entity)
  render(plain: entity.errors.messages,
         status: :unprocessable_entity)
end
