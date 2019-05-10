require "rails_helper"


describe "as a visitor" do

  describe "when I vist astronaut index'" do

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

    it "displays astronaut info" do

      visit astronauts_path

      within("#astronaut-#{@astronaut_1.id}")  do
          expect(page).to have_content(@astronaut_1.name)
          expect(page).to have_content(@astronaut_1.age)
          expect(page).to have_content(@astronaut_1.job)
          expect(page).to_not have_content(@astronaut_2.name)
      end
      within("#astronaut-#{@astronaut_2.id}")  do
          expect(page).to have_content(@astronaut_2.name)
          expect(page).to have_content(@astronaut_2.age)
          expect(page).to have_content(@astronaut_2.job)
          expect(page).to_not have_content(@astronaut_1.name)
      end

    end

    it "shows astronauts average age" do
      visit astronauts_path
      expect(page).to have_content("Average Age: 32")
    end


    it "Lists eash astronauts missions" do
      visit astronauts_path
      within("#astronaut-#{@astronaut_1.id}")  do
        expect(page).to have_content(@mission_1.title)
        expect(page).to have_content(@mission_2.title)
        expect(page).to_not have_content(@mission_3.title)
      end
      within("#astronaut-#{@astronaut_2.id}")  do
        expect(page).to have_content(@mission_3.title)
        expect(page).to have_content(@mission_2.title)
        expect(page).to_not have_content(@mission_1.title)
      end
    end

    it "displays total time in space for eash astronaut" do
      visit astronauts_path
      within("#astronaut-#{@astronaut_1.id}")  do
        expect(page).to have_content("Total time in space: 66")
      end
      within("#astronaut-#{@astronaut_2.id}")  do
        expect(page).to have_content("Total time in space: 55")
      end


    end



  end
end
