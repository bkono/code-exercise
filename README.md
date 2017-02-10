# RFA Code Exercise
This exercise involves improving a fictional subset of a Ruby on Rails 5.x application.  It only contains a model, controller, and two views.

You should assume the technology stack used for this code includes:
* Ruby on Rails 5.x
* Ruby 2.3.x (MRI)
* PostgreSQL Database
* ERB
* jQuery
* Moment.js

## Instructions

Refactor and improve the code.  Add directories/files as needed.

You are not expected to run the code or make this work as a real Rails application.

## Refactorer's Notes

Given the instructions are simply to refactor and improve, without specific input on any of the
business cases that app should be addressing, I'm going to make a few different passes through the
codebase with various areas of focus. Where there are questions, I'll call out assumptions made on
behalf of the fictional stakeholders.

- [x] Pass 1, simple refactoring and cleanup of model and controller's existing logic
- [ ] Pass 2, view cleanup, possibly introduce a Presenter pattern given the excessive logic
- [ ] Pass 3, "uncover" business logic of sufficient complexity to warrant additions of service
    objects (ie: task POROs), other common significant application dependencies and structures
- [ ] Pass 4, make it a real rails app so we can introduce testing. Flying blind is no fun at all.
    Not a fan of cowboy refactors without any test coverage (see Pass 1)
