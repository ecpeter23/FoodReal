from bs4 import BeautifulSoup  # For parsing HTML
from datetime import date  # For getting the current date
import requests  # For making HTTP requests
import json  # For JSON parsing and formatting
import firebase_admin  # For Firebase administration
from firebase_admin import credentials  # For handling Firebase credentials
from firebase_admin import firestore  # For Firestore operations
from enum import Enum  # For creating enumeration types

# Enum class to represent different meal times
class Time(Enum):
    BREAKFAST = 1
    LUNCH = 2
    DINNER = 3

# Function to get the menu from a URL
def get_menu(url, menu_id):
    # Sending a GET request to the URL
    response = requests.get(url)
    # Checking if the request was successful
    if response.status_code != 200:
        raise ConnectionError("Failed to retrieve data from the URL.")
    # Parsing the HTML content of the page
    page_content = BeautifulSoup(response.content, "html.parser")
    # Returning the content identified by the menu_id
    return page_content.find(id=menu_id)

# Function to split the menu into sections and titles
def split_menu(menu, meal_type):
    # Finding all menu sections
    menu_sections = menu.find_all(class_="bite-menu-item")
    # Extracting menu titles
    menu_titles = [title.get_text() for title in menu.find_all('h5')]
    # Returning the sections and titles
    return menu_sections, menu_titles

# Function to extract food items from a section
def extract_food_items(section):
    # Extracting food items based on a specific attribute
    return [item['data-fooditemname'] for item in section.find_all('a', attrs={'data-fooditemname': True})]

# Function to extract meal data based on menu and titles
def extract_meal_data(menu, titles):
    # Creating a dictionary of meal data
    return {title: extract_food_items(menu[i]) for i, title in enumerate(titles)}

# Function to initialize Firebase with credentials
def initialize_firebase(cred_path):
    # Loading credentials from a file
    cred = credentials.Certificate(cred_path)
    # Initializing the Firebase app with the loaded credentials
    firebase_admin.initialize_app(cred)

# Main function
def main():
    # URL and menu ID for fetching the menu
    url = "https://menus.sodexomyway.com/BiteMenu/Menu?menuId=16872&locationId=97451005&whereami=https://lehigh.sodexomyway.com/dining-near-me/rathbone"
    current_menu_id = f'menuid-{date.today().day}-day'
    menu = get_menu(url, current_menu_id)

    # Dictionary to store data
    data = {}
    # Iterating over each meal time
    for meal in Time:
        meal_str = meal.name.lower()
        meal_html = menu.find(class_=f"accordion-block {meal_str}").find(class_="accordion-panel rtf hide")
        sections, titles = split_menu(meal_html, meal)
        data[meal_str.capitalize()] = extract_meal_data(sections, titles)

    # Initializing Firebase
    # initialize_firebase("api key")
    
    # Printing the extracted data in JSON format
    print(json.dumps(data, indent=2))

# Checking if the script is the main program and running the main function
if __name__ == "__main__":
    main()
