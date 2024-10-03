module JsonCustomResponse
  def self.reformat(data, error, status_code)
    {
      "data": data,
      "error": error,
      "status_code": status_code
    }
  end
end