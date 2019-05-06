# TraceLocation

TraceLocation helps you get tracing the source location of codes, and helps you can get reading the huge open souce libraries in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trace_location'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trace_location

## Usage

You just surround the code which you want to track the process.

### Example 01. Track the lifecycle of Rails application


```
% bin/rails c

irb(main):001:0> env = Rack::MockRequest.env_for('http://localhost:3000/books')
irb(main):002:0> TraceLocation.trace { status, headers, body = Rails.application.call(env) }
Created at /path/to/sampleapp/log/trace_location-2019050602051557077971.log
=> true
```

Then you can get a log like this:

```
Logged by TraceLocation gem at 2019-05-06 02:39:31 +0900
https://github.com/yhirano55/trace_location

[Tracing events] C: Call, R: Return

C /railties-5.2.3/lib/rails.rb:39 [Rails.application]
R /railties-5.2.3/lib/rails.rb:41 [Rails.application]
C /railties-5.2.3/lib/rails/engine.rb:522 [Rails::Engine#call]
  C /railties-5.2.3/lib/rails/application.rb:607 [Rails::Application#build_request]
    C /railties-5.2.3/lib/rails/engine.rb:705 [Rails::Engine#build_request]
      C /railties-5.2.3/lib/rails/application.rb:247 [Rails::Application#env_config]
        C /railties-5.2.3/lib/rails/engine.rb:528 [Rails::Engine#env_config]
        R /railties-5.2.3/lib/rails/engine.rb:530 [Rails::Engine#env_config]
        C /railties-5.2.3/lib/rails/application.rb:372 [Rails::Application#config]
        R /railties-5.2.3/lib/rails/application.rb:374 [Rails::Application#config]
        C /railties-5.2.3/lib/rails/application.rb:372 [Rails::Application#config]
        R /railties-5.2.3/lib/rails/application.rb:374 [Rails::Application#config]
        C /railties-5.2.3/lib/rails/application.rb:394 [Rails::Application#secrets]
        R /railties-5.2.3/lib/rails/application.rb:414 [Rails::Application#secrets]
        C /activesupport-5.2.3/lib/active_support/ordered_options.rb:41 [ActiveSupport::OrderedOptions#method_missing]
          C /activesupport-5.2.3/lib/active_support/ordered_options.rb:37 [ActiveSupport::OrderedOptions#[]]
          R /activesupport-5.2.3/lib/active_support/ordered_options.rb:39 [ActiveSupport::OrderedOptions#[]]
        R /activesupport-5.2.3/lib/active_support/ordered_options.rb:54 [ActiveSupport::OrderedOptions#method_missing]
        C /railties-5.2.3/lib/rails/application.rb:428 [Rails::Application#secret_key_base]
          C /railties-5.2.3/lib/rails.rb:72 [Rails.env]
          R /railties-5.2.3/lib/rails.rb:74 [Rails.env]
          C /activesupport-5.2.3/lib/active_support/string_inquirer.rb:26 [ActiveSupport::StringInquirer#method_missing]
          R /activesupport-5.2.3/lib/active_support/string_inquirer.rb:32 [ActiveSupport::StringInquirer#method_missing]
          C /railties-5.2.3/lib/rails/application.rb:394 [Rails::Application#secrets]
          R /railties-5.2.3/lib/rails/application.rb:414 [Rails::Application#secrets]
          C /activesupport-5.2.3/lib/active_support/ordered_options.rb:41 [ActiveSupport::OrderedOptions#method_missing]
            C /activesupport-5.2.3/lib/active_support/ordered_options.rb:37 [ActiveSupport::OrderedOptions#[]]
            R /activesupport-5.2.3/lib/active_support/ordered_options.rb:39 [ActiveSupport::OrderedOptions#[]]
          R /activesupport-5.2.3/lib/active_support/ordered_options.rb:54 [ActiveSupport::OrderedOptions#method_missing]
        R /railties-5.2.3/lib/rails/application.rb:436 [Rails::Application#secret_key_base]
..................
(an omission)
..................
```

### Example 02. Track the validation process of Active Record

```
% bin/rails c

irb(main):001:0> book = Book.new(title: "My Book Title")
irb(main):002:0> TraceLocation.trace { book.validate }
Created at /path/to/sampleapp/log/trace_location-2019050104049576006131.log
=> true
```

Then you can get a log like this:

```
Logged by TraceLocation gem at 2019-05-06 02:44:29 +0900
https://github.com/yhirano55/trace_location

[Tracing events] C: Call, R: Return

C /activerecord-5.2.3/lib/active_record/validations.rb:65 [ActiveRecord::Validations#valid?]
  C /activerecord-5.2.3/lib/active_record/validations.rb:75 [ActiveRecord::Validations#default_validation_context]
    C /activerecord-5.2.3/lib/active_record/persistence.rb:231 [ActiveRecord::Persistence#new_record?]
      C /activerecord-5.2.3/lib/active_record/transactions.rb:490 [ActiveRecord::Transactions#sync_with_transaction_state]
        C /activerecord-5.2.3/lib/active_record/transactions.rb:494 [ActiveRecord::Transactions#update_attributes_from_transaction_state]
        R /activerecord-5.2.3/lib/active_record/transactions.rb:500 [ActiveRecord::Transactions#update_attributes_from_transaction_state]
      R /activerecord-5.2.3/lib/active_record/transactions.rb:492 [ActiveRecord::Transactions#sync_with_transaction_state]
    R /activerecord-5.2.3/lib/active_record/persistence.rb:234 [ActiveRecord::Persistence#new_record?]
  R /activerecord-5.2.3/lib/active_record/validations.rb:77 [ActiveRecord::Validations#default_validation_context]
  C /activemodel-5.2.3/lib/active_model/validations.rb:336 [ActiveModel::Validations#valid?]
    C /activemodel-5.2.3/lib/active_model/validations.rb:303 [ActiveModel::Validations#errors]
      C /activemodel-5.2.3/lib/active_model/errors.rb:74 [ActiveModel::Errors#initialize]
        C /activemodel-5.2.3/lib/active_model/errors.rb:470 [ActiveModel::Errors#apply_default_array]
        R /activemodel-5.2.3/lib/active_model/errors.rb:473 [ActiveModel::Errors#apply_default_array]
        C /activemodel-5.2.3/lib/active_model/errors.rb:470 [ActiveModel::Errors#apply_default_array]
        R /activemodel-5.2.3/lib/active_model/errors.rb:473 [ActiveModel::Errors#apply_default_array]
      R /activemodel-5.2.3/lib/active_model/errors.rb:78 [ActiveModel::Errors#initialize]
    R /activemodel-5.2.3/lib/active_model/validations.rb:305 [ActiveModel::Validations#errors]
    C /activemodel-5.2.3/lib/active_model/errors.rb:115 [ActiveModel::Errors#clear]
    R /activemodel-5.2.3/lib/active_model/errors.rb:118 [ActiveModel::Errors#clear]
    C /activemodel-5.2.3/lib/active_model/validations/callbacks.rb:117 [ActiveModel::Validations::Callbacks#run_validations!]
      C /activesupport-5.2.3/lib/active_support/callbacks.rb:815 [ActiveRecord::Base#_run_validation_callbacks]
        C /activesupport-5.2.3/lib/active_support/callbacks.rb:94 [ActiveSupport::Callbacks#run_callbacks]
          C /activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:124 [ActiveRecord::Base#__callbacks]
            C /activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:106 [ActiveRecord::Base.__callbacks]
            R /activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:128 [ActiveRecord::Base.__callbacks]
          R /activesupport-5.2.3/lib/active_support/callbacks.rb:95 [ActiveRecord::Base#__callbacks]
          C /activesupport-5.2.3/lib/active_support/callbacks.rb:539 [ActiveSupport::Callbacks::CallbackChain#empty?]
          R /activesupport-5.2.3/lib/active_support/callbacks.rb:539 [ActiveSupport::Callbacks::CallbackChain#empty?]
          C /activemodel-5.2.3/lib/active_model/validations.rb:408 [ActiveModel::Validations#run_validations!]
            C /activesupport-5.2.3/lib/active_support/callbacks.rb:815 [ActiveRecord::Base#_run_validate_callbacks]
              C /activesupport-5.2.3/lib/active_support/callbacks.rb:94 [ActiveSupport::Callbacks#run_callbacks]
                C /activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:124 [ActiveRecord::Base#__callbacks]
                  C /activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:106 [ActiveRecord::Base.__callbacks]
                  R /activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:128 [ActiveRecord::Base.__callbacks]
                R /activesupport-5.2.3/lib/active_support/callbacks.rb:95 [ActiveRecord::Base#__callbacks]
                C /activesupport-5.2.3/lib/active_support/callbacks.rb:539 [ActiveSupport::Callbacks::CallbackChain#empty?]
                R /activesupport-5.2.3/lib/active_support/callbacks.rb:539 [ActiveSupport::Callbacks::CallbackChain#empty?]
              R /activesupport-5.2.3/lib/active_support/callbacks.rb:139 [ActiveSupport::Callbacks#run_callbacks]
            R /activesupport-5.2.3/lib/active_support/callbacks.rb:817 [ActiveRecord::Base#_run_validate_callbacks]
            C /activemodel-5.2.3/lib/active_model/validations.rb:303 [ActiveModel::Validations#errors]
            R /activemodel-5.2.3/lib/active_model/validations.rb:305 [ActiveModel::Validations#errors]
            C /activemodel-5.2.3/lib/active_model/errors.rb:209 [ActiveModel::Errors#empty?]
              C /activemodel-5.2.3/lib/active_model/errors.rb:179 [ActiveModel::Errors#size]
                C /activemodel-5.2.3/lib/active_model/errors.rb:188 [ActiveModel::Errors#values]
                R /activemodel-5.2.3/lib/active_model/errors.rb:192 [ActiveModel::Errors#values]
              R /activemodel-5.2.3/lib/active_model/errors.rb:181 [ActiveModel::Errors#size]
            R /activemodel-5.2.3/lib/active_model/errors.rb:211 [ActiveModel::Errors#empty?]
          R /activemodel-5.2.3/lib/active_model/validations.rb:411 [ActiveModel::Validations#run_validations!]
        R /activesupport-5.2.3/lib/active_support/callbacks.rb:139 [ActiveSupport::Callbacks#run_callbacks]
      R /activesupport-5.2.3/lib/active_support/callbacks.rb:817 [ActiveRecord::Base#_run_validation_callbacks]
    R /activemodel-5.2.3/lib/active_model/validations/callbacks.rb:119 [ActiveModel::Validations::Callbacks#run_validations!]
  R /activemodel-5.2.3/lib/active_model/validations.rb:342 [ActiveModel::Validations#valid?]
  C /activemodel-5.2.3/lib/active_model/validations.rb:303 [ActiveModel::Validations#errors]
  R /activemodel-5.2.3/lib/active_model/validations.rb:305 [ActiveModel::Validations#errors]
  C /activemodel-5.2.3/lib/active_model/errors.rb:209 [ActiveModel::Errors#empty?]
    C /activemodel-5.2.3/lib/active_model/errors.rb:179 [ActiveModel::Errors#size]
      C /activemodel-5.2.3/lib/active_model/errors.rb:188 [ActiveModel::Errors#values]
      R /activemodel-5.2.3/lib/active_model/errors.rb:192 [ActiveModel::Errors#values]
    R /activemodel-5.2.3/lib/active_model/errors.rb:181 [ActiveModel::Errors#size]
  R /activemodel-5.2.3/lib/active_model/errors.rb:211 [ActiveModel::Errors#empty?]
R /activerecord-5.2.3/lib/active_record/validations.rb:69 [ActiveRecord::Validations#valid?]

Result: true
```

## License

[MIT License](https://opensource.org/licenses/MIT)
