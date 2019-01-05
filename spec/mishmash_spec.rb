require './lib/mishmash'

describe "Mishmash" do
  
  it "should respond to new" do
    expect(Mishmash.respond_to?('new')).to be(true)
  end
  
  describe "output" do
    it "shgould respond to translate" do
      expect(Mishmash.new({"key" => "value"}).respond_to?("translate")).to be(true)
    end
  end

  context "translate with alternate schema" do

    it "root keys"  do
      hash = Mishmash.new({"key" => "value"})
      expect(hash.translate({"key" => "new_key"})).to eq({"new_key" => "value"}) 
    end

    it "nested keys to root keys" do
      hash = Mishmash.new({"hash" => {"key" => "value"}})
      expect(hash.translate({"hash" => {"key" => "new_key"}})).to eq({"new_key" => "value"}) 
    end
  end
  
  describe "given an input, schema and output" do
    let(:input){
      {
        "array" => [
          {"key" => "value 1"}, 
          {"key" => "value 2"}
          ]
      }
    }
    let(:output){
      { 
        "array_of_values" => ["value 1", "value 2"]
      }
    }
    
    let(:schema) {
      {"array" => {"key" => "array_of_values"}}
    }
    it "Translate an Array of Hashes to Hash of Arrays with a schema" do
      expect(Mishmash.new(input).translate(schema)).to eq(output)
    end
  end
  
  describe "given an input with an array of hashes" do
    let(:input){
      {
        "array" => [
          {"key" => "value 1"}, 
          {"key" => "value 2"}
          ]
      }
    }
    describe "return a hash with array of values" do
      let(:output){
        { 
          "key" => ["value 1", "value 2"]
        }
      }
      let(:schema) {
        {"array" => {"key" => "key"}}
      }
      it "with an alternate key_name" do
        expect(Mishmash.new(input).translate(schema)).to eq(output)
      end
    end
  end
  
  describe "given an input with an array of hashes" do
    let(:input){
      {
        "array" => [
          {"key" => "value 1"}, 
          {"key" => "value 2"}
          ]
      }
    }
    describe "return a hash with array of values" do
      let(:output){
        { 
          "key" => ["value 1", "value 2"]
        }
      }
      let(:schema) {
        {"array" => {"key" => "key"}}
      }
      it "with an alternate key_name" do
        expect(Mishmash.new(input).translate(schema)).to eq(output)
      end
    end
  end
  
  describe "given an input with an array of hashes" do
    let(:input){
      {
        "array" => [
          {"option"=> "1", "value" => "X"},
          {"option"=> "2", "value" => "Y"}
        ]
      }
    }
    describe "return a hash matching a condition" do
      let(:output){
        {"option" => "X"}
      }
      let(:schema) {
        {"array" => {"option" => "1", "value" => "option"}}
      }
      it "with an alternate key_name" do
        expect(Mishmash.new(input).translate(schema)).to eq(output)
      end
    end
  end
  
  describe "given an input with an array of hashes" do
    let(:input){
      {
        "array" => [
          {"option"=> "1", "value" => "X"},
          {"option"=> "2", "value" => "Y"}
        ]
      }
    }
    describe "return a hash matching a condition" do
      let(:output){
        {"option" => "X"}
      }
      let(:schema) {
        {"array" => {"option" => "1", "value" => "option"}}
      }
      it "with an alternate key_name" do
        expect(Mishmash.new(input).translate(schema)).to eq(output)
      end
    end
  end
  
  describe "given an input with an array of hashes" do
    let(:input){
      {
        "array" => [
          {"option"=> "1", "value" => "X"},
          {"option"=> "2", "value" => "Y"}
        ]
      }
    }
    describe "return an array of translated and filtered hashes" do
      let(:output){
        {"new array" => [
          {"attribute" => "X"},
          {"attribute" => "Y"}
        ]}
      }
      let(:schema) {
        {"array" => [ "new array",  {"value" => "attribute"} ] }
      }
      it "with an alternate key_name" do
        expect(Mishmash.new(input).translate(schema)).to eq(output)
      end
    end
  end
end