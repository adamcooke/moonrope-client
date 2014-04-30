# Moonrope Ruby Client

This is a Ruby client library for interacting with Moonrope-enabled API 
endpoints from Ruby. Using this library is extremely simple and should only
take a few seconds to get up and running.

## Installation

To begin, just install the library into your Gemfile and require it.

```ruby
gem 'moonrope-client', '~> 1.0.0'
```

## Usage

The following instructions demonstrate some of the ways you can interact with
your external API.

```ruby

# Set some headers and initialize a new connection object. All requests will
# go through this connection instance.
headers= {'X-Auth-Header' => 'abc123abc123abc'}
mr = MoonropeClient::Connection.new('myapp.com', :headers => headers, :ssl => true)

# Make a request. In this example, we're making a request to the list action
# on the users controller.
response = mr.request(:users, :list, :page => 1)
```

The object you get back from calling `request` will determine on the status
of the request. All responses inherit from `MoonropeClient::Response` which
responds to the following methods:

```ruby
response.status         #=> Returns the text status received from the API
response.success?       #=> true or false
response.flags          #=> Returns a hash of all response flags
response.time           #=> Returns the time to execute the request on the server
response.data           #=> Return the data returned by the API
```

### Successful responses

If your request is successful, it will be an instance of a 
`MoonropeClient::Reponses::Success` and will expose the additional methods 
shown below:

```ruby
response.creation?      #=> Whether or not the request was a creation
response.modification?  #=> Whether or not the request was a modification
response.deletion?      #=> Whether or not the request was a deletion
```

#### Paginated Data

In some instances, the API may return paginated data to you. If this happens,
your response will be an instance of `MoonropeClient::Responses::PaginatedCollection`
and will have the following additional methods:

```ruby
response.page           #=> The current page
response.per_page       #=> The number of records per page
response.total_pages    #=> The total number of pages available
response.total_records  #=> The total number of records available
response.records        #=> An array of all records
```

In addition to these methods, you can use the following methods to make a new
request for the next or previous page.

```ruby
response.next_page      #=> Another PaginatedCollection instance for page + 1
response.previous_page  #=> Another PaginatedCollection instance for page + 2
```

### Access Denied

If your request is denied, your response will be an instance of 
`MoonropeClient::Responses::AccessDenied` and will have a `message` method
which will contain the details of your denial.

### Parameter errors

If the parameters you provided to the request are invalid, response will
be an instance of `MoonropeClient::Responses::ParameterError`. This will
have a `message` method which will return the details of the error.

### Validation error

If a validation error has ocurred, response will be an instance of 
`MoonropeClient::Responses::ValidationError`. This will have a `errors` method
which contains details of the validation errors.
