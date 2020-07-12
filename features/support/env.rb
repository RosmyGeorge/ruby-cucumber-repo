require 'yaml'
require 'page-object'
require 'watir-webdriver'
require 'selenium-webdriver'
require 'page-object/page_factory'
require 'rspec'
require 'rake'
require 'pry'
require 'watir-scroll'

World(PageObject)
World(PageObject::PageFactory)



$ENVIRONMENT= YAML.load(File.open(File.expand_path('../../../', __FILE__)+'/config.yml'))
puts $ENVIRONMENT
$BASE_URL =$ENVIRONMENT['production']