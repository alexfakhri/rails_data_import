Rails Data Import
========

A basic rails application that imports data from a text file and saves it the database.

Tasks
----
Deliverables:

 - [x] A rails application and associated database to hold the data
 - [x] A basic web front-end to view the results which should;
   - [x]Present a list of campaigns for which we have results.
   - [x] When the user clicks on a campaign, present a list of the
     candidates, their scores, and the number of messages which were sent in
     but not counted
 - [x] A command-line script that will import log file data into the application.
   Any lines that are not well-formed should be discarded.
 - [x] A description of your approach to this problem, including any
   significant design decisions and your reasoning in making your
   choices.

Tech Used:
-----
- Ruby on Rails 5.0
- Postgresql - For database
- RSpec & Capybara - For testing
- Bootstrap - For styling

How to use
----------
Clone the repository:
```shell
$ git clone https://github.com/alexfakhri/rails_data_import.git

```

Change into the directory:
```shell
$ cd rails_data_import
```

Install dependencies:
```shell
$ bundle install
```

To setup database:
```shell
$ rails db:create db:migrate
```

To see RSpec tests:
```shell
$ rspec
```

Run application:
```shell
$ bin/rails server
in browser go to: http://localhost:3000/
```

To import data:
-----

To import data using the rake task run the following command: 'rake import_file:import[file-path]', replacing file-path with the path to the file you want to import. Eg:

Run:
```
$ rake import_file:import[public/votes.txt]
```

ZSH Users:
```
$ rake "import_file:import[public/votes.txt]"
```
The app assumes the file lives somewhere in your rails directory. The sample data provided has been put into the public folder, add files you want to import into the public folder and run the commands above.

Solving the problem:
-----
- My approach was simple and followed the deliverables provided:
  - A rails application and associated database to hold the data:
    - First I created the basic rails application with a PostgreSQL database and RSpec and Capybara for testing.
  - A basic web front-end to view the results which should:
    - I started with creating the models, controllers and views required to store and display the data.
    - Looking at the data I decided to store them in two different tables: campaigns and votes. Votes belongs to a campaign, a campaign has many votes.
    - This was the most logical approach and the easiest way to deal with the data, campaigns are created if there is an ID present that has not been used before, if the campaign exists the vote would belong to that campaign. This also made the counting and grouping of the votes easier to deal with.
  - A command-line script that will import log file data into the application. Any lines that are not well-formed should be discarded:
    - For the data import I decided to use a PORO(Plain old Ruby object) to parse the data and write it to the database.
    - Following Single Responsibility Principle I felt like this was the best approach to it, as the models should not be responsible for carrying out the processing, it should be it's own ruby object that would take care of this process.
    - In the models folder I created LogFileImporter class that takes a given file and processes it. It opens the file, takes every line individually, ensures that the data is valid and writes it to the correct models.
    - Finally created a rake task that you can use in the command line to import data: 'rake import_file:import[public/votes.txt]'


- I've used Capybara for feature testing and RSpec for unit testing and model testing. I've followed TDD and BDD throughout the application to ensure good test coverage.
