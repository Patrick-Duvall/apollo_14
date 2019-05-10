require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  before :each do
    @astronaut_1 = Astronaut.create!(name: 'Joe', age: 22, job: 'first mate')
    @astronaut_2 = Astronaut.create!(name: 'Mary', age: 42, job: 'captain')
    @mission_1 = Mission.create!(title: 'Mission 1', time_in_space: 22)
    @mission_2 = Mission.create!(title: 'Mission 2', time_in_space: 44)
    @mission_3 = Mission.create!(title: 'Mission 3', time_in_space: 11)
    AstronautMission.create!(astronaut: @astronaut_1, mission: @mission_1)
    AstronautMission.create!(astronaut: @astronaut_1, mission: @mission_2)
    AstronautMission.create!(astronaut: @astronaut_2, mission: @mission_2)
    AstronautMission.create!(astronaut: @astronaut_2, mission: @mission_3)
  end


  describe ".average_age" do
    it "shows average age" do
    expect(Astronaut.average_age).to eq(32)
  end
  end
  describe ".total_time_in_space" do
    it "shows time_in_space" do

    expect(@astronaut_1.total_time_in_space).to eq(66)
    expect(@astronaut_2.total_time_in_space).to eq(55)
  end
  end
end
