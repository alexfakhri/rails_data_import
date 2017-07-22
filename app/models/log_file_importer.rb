class LogFileImporter

  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    file_path = Rails.root + @file
    return puts "file not found" if file_path.nil? || !File.exists?(file_path)

    File.open(Rails.root + file_path).each do |line|
      line = line.chomp
      data = parse_data(line)
      next if data.nil?
      write_to_table(data)
    end
  end

  def parse_data(line)
    line.match(/\A (?<vote>\VOTE)\s+ (?<time>\d+)\s+ Campaign:(?<campaign>ssss\w+)\s+ Validity:(?<validity>\w+)\s+ Choice:(?<choice>\w+)/x)
  end

  def write_to_table(data)
    puts data
    campaign = Campaign.find_or_create_by(campaign: data[:campaign])
    Vote.create(epoch_time_value: data[:time].to_i, validity: data[:validity], choice: data[:choice], campaign: campaign)
  end

end
