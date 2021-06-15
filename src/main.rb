require 'sinatra'
require 'json'
require 'cgi'


def number_or_nil(string)
    num = string.to_i
    num if num.to_s == string
end

def square(int_x)
    square_ans = int_x * int_x
end

get '/' do
    content_type :json
    response['Access-Control-Allow-Origin'] = '*'

    {"params" => CGI::parse(request.query_string)}.to_json
    x_val = params['x']

    if x_val == nil || x_val == ""
        body = { error: "Param x is missing" }.to_json
        halt(200, body)
    end

    # if cant be converted return error
    if number_or_nil(x_val) == nil
        body = { error: "Param x is not an integer" }.to_json
        halt(200, body)
    end

    # convert to int
    x_val = x_val.to_i

    square_ans = square(x_val)

    { error: "", x: x_val, answer: square_ans }.to_json
end
