import sys
import rapidjson as json
import optional_faker as _
import uuid
import random

from dotenv import load_dotenv
from faker import Faker
from datetime import date, datetime

load_dotenv()
fake = Faker()
brands = ["WESTIN", "SHERATON", "THE LUXURY COLLECTION", "FOUR POINTS BY SHERATON", "W HOTELS",
          "ST. REGIS", "LE MERIDIEN", "ALOFT", "ELEMENT", "TRIBUTE PRTFOLIO", "DESIGN HOTELS"]    


def create_locations():
    global brands, fake
    state = fake.state_abbr()
    locations = {'id': fake.random_int(min=1000, max=1999),
                'brand': fake.random_element(elements=brands),
                'address': fake.optional({'street_address': fake.street_address(), 
                                             'city': fake.city(), 'state': state, 
                                             'postalcode': fake.postalcode_in_state(state)}),
                'phone': fake.optional(fake.phone_number())                
    }
    locs = []
    for location in locations:
        locs.append(location.id)

def create_stays():
    global brands, locations, fake
    state = fake.state_abbr()
    brand = fake.random_element(elements=brands)
    brand_locations = locs
    stay = {'txid': str(uuid.uuid4()),
                   'brand': brand,
                   'location': fake.random_element(elements=locations),
                   'reservation_date': fake.date_this_decade(),
                   'rooms': fake.random_int(min=1, max=4),
                   'days': fake.random_int(min=1, max=7),
                   'name': fake.name(),
                   'address': fake.optional({'street_address': fake.street_address(), 
                                             'city': fake.city(), 'state': state, 
                                             'postalcode': fake.postalcode_in_state(state)}),
                   'phone': fake.optional(fake.phone_number()),
                   'email': fake.optional(fake.email()),
    }
    d = json.dumps(brands) + '\n'
    sys.stdout.write(d)


if __name__ == "__main__":
    args = sys.argv[1:]
    total_count = int(args[0])
    for _ in range(total_count):
        create_locations()
    print('')