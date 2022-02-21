from flask import Flask, request, session, redirect, url_for, render_template, flash
import psycopg2  # pip install psycopg2
import psycopg2.extras
from sqlalchemy import null
from werkzeug.utils import secure_filename
import re
import random
from werkzeug.security import generate_password_hash, check_password_hash
from jinja2 import StrictUndefined
from pyowm.owm import OWM
import os
import model
# Handles image upload and storage
import cloudinary
from cloudinary.uploader import upload
import cloudinary.api

#########################
# REFACTOR ME
# Import functions for image storage and processing
from image_handling import allowed_file, ALLOWED_EXTENSIONS

from datetime import datetime
from global_var import CITIES, MONTHS

app = Flask(__name__)
app.secret_key = 'gotta-change_this_soooon'

DB_HOST = "localhost"
DB_NAME = "Unfold"
DB_USER = "postgres"
DB_PASS = "ketto|69"

conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST)
UPLOAD_FOLDER = 'static/uploads/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024

ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

owm = OWM('2e55b43611522f33e344825cf2966521')


@app.route('/')
def home():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # Check if user is loggedin
    if 'loggedin' in session:
        cursor.execute('SELECT * FROM users WHERE id = %s', [session['id']])
        user = cursor.fetchone()

        mgr = owm.weather_manager()
        observation = mgr.weather_at_place('Nairobi')  # the observation object is a box containing a weather object
        weather = observation.weather
        weather.status  # short version of status (eg. 'Rain')
        weather.detailed_status
        temp_dict_celsius = weather.temperature('celsius')
        temp_dict_celsius['temp_min']
        temp_dict_celsius['temp_max']

        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        result = cur.execute('SELECT count(*) FROM public.articles')
        number_of_articles = cur.fetchone()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        result = cur.execute('SELECT count(*) FROM public.categories')
        number_of_categories = cur.fetchone()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        result = cur.execute('SELECT count(*) FROM public.outfits')
        number_of_outfits = cur.fetchone()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        result = cur.execute('SELECT count(*) FROM public.wear_events')
        number_of_wear_events = cur.fetchone()

        return render_template('home.html', user=session['username'], CITIES=CITIES, weather=weather,
                               temp_dict_celsius=temp_dict_celsius, number_of_articles=number_of_articles,
                               number_of_categories=number_of_categories, number_of_outfits=number_of_outfits,
                               number_of_wear_events=number_of_wear_events)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))


@app.route('/login/', methods=['GET', 'POST'])
def login():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # Check if "username" and "password" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']
        print(password)

        # Check if account exists using MySQL
        cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
        # Fetch one record and return result
        account = cursor.fetchone()

        if account:
            password_rs = account['password']
            print(password_rs)
            # If account exists in users table in out database
            if check_password_hash(password_rs, password):
                # Create session data, we can access this data in other routes
                session['loggedin'] = True
                session['id'] = account['id']
                session['username'] = account['username']
                # Redirect to home page
                return redirect(url_for('home'))
            else:
                # Account doesnt exist or username/password incorrect
                flash('Incorrect username/password')
        else:
            # Account doesnt exist or username/password incorrect
            flash('Incorrect username/password')

    return render_template('login.html')


@app.route('/register', methods=['GET', 'POST'])
def register():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # Check if "username", "password" and "email" POST requests exist (user submitted form)
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        # Create variables for easy access
        fullname = request.form['fullname']
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']

        _hashed_password = generate_password_hash(password)

        # Check if account exists using MySQL
        cursor.execute('SELECT * FROM users WHERE username = %s', (username,))
        account = cursor.fetchone()
        print(account)
        # If account exists show error and validation checks
        if account:
            flash('Account already exists!')
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            flash('Invalid email address!')
        elif not re.match(r'[A-Za-z0-9]+', username):
            flash('Username must contain only characters and numbers!')
        elif not username or not password or not email:
            flash('Please fill out the form!')
        else:
            # Account doesnt exists and the form data is valid, now insert new account into users table
            cursor.execute("INSERT INTO users (fullname, username, password, email) VALUES (%s,%s,%s,%s)",
                           (fullname, username, _hashed_password, email))
            conn.commit()
            flash('You have successfully registered!')
    elif request.method == 'POST':
        # Form is empty... (no POST data)
        flash('Please fill out the form!')
    # Show registration form with message (if any)
    return render_template('register.html')


@app.route('/logout')
def logout():
    # Remove session data, this will log the user out
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    # Redirect to login page
    return redirect(url_for('login'))


@app.route('/profile')
def profile():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # Check if user is loggedin
    if 'loggedin' in session:
        cursor.execute('SELECT * FROM users WHERE id = %s', [session['id']])
        account = cursor.fetchone()
        # Show the profile page with account info
        return render_template('profile.html', account=account)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))


@app.route('/closet')
def closet():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # Check if user is loggedin
    if 'loggedin' in session:
        cursor.execute('SELECT * FROM users WHERE id = %s', [session['id']])
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        result = cur.execute("SELECT * FROM public.categories ORDER BY category_id ASC")
        categories = cur.fetchall()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        result = cur.execute("SELECT * FROM public.base_categories ORDER BY base_category_id ASC")
        base_categories = cur.fetchall()
        return render_template('closet.html', categories=categories, base_categories=base_categories)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))


@app.route('/closet/<category_id>')
def show_category_articles(category_id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('SELECT * FROM public.articles WHERE category_id = %s', (category_id,))
    articles = cur.fetchall()
    result = cur.execute('SELECT * FROM public.categories WHERE category_id = %s', (category_id,))
    category = cur.fetchone()

    return render_template("single-category.html",
                           articles=articles,
                           category=category)


@app.route('/add-category')
def show_create_category_form():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.base_categories ORDER BY base_category_id ASC")
    base_categories = cur.fetchall()

    return render_template("add-category.html",
                           base_categories=base_categories)


@app.route('/create-category', methods=['GET', 'POST'])
def add_category():
    """Adds new user-created category and redirects to /categories."""
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.base_categories ORDER BY base_category_id ASC")
    base_categories = cur.fetchall()
    message = ""
    if request.method == 'POST':
        cur.execute('SELECT * FROM users WHERE id = %s', [session['id']])
        account = cur.fetchone()
        id = account[session['id']]
        name = request.form['category-name']
        base_category_id = request.form['base-category']
        description = request.form['category-description']

        cur.execute("INSERT INTO categories (name, base_category_id, id , description) VALUES (%s,%s,%s,%s)",
                    (name, base_category_id, 1, description))
        conn.commit()
        cur.close()
    return redirect('/closet')


@app.route('/add-article')
def show_create_article_form():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.categories ORDER BY base_category_id ASC")
    categories = cur.fetchall()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.tags ORDER BY tag_id ASC")
    tags = cur.fetchall()
    return render_template('add-article.html', tags=tags, categories=categories)


@app.route('/create-article', methods=['POST'])
def add_article():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    file = request.files['file']
    if file.filename == '':
        flash('No image selected for uploading')
        return redirect(request.url)
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        # print('upload_image filename: ' + filename)
        description = request.form['article-description']
        purchase_price = request.form['purchase-price']
        category_id = request.form['category']
        cursor.execute(
            "INSERT INTO articles (description, image, purchase_price, times_worn, id, category_id) VALUES (%s,%s,%s,"
            "%s,%s,%s)",
            (description, filename, purchase_price, 0, 1, category_id))
        conn.commit()

        flash('Image successfully uploaded and displayed below')
        return render_template('add-article.html', filename=filename)
    else:
        flash('Allowed image types are - png, jpg, jpeg, gif')
        return redirect(request.url)


@app.route('/display/<filename>')
def display_image(filename):
    # print('display_image filename: ' + filename)
    return redirect(url_for('static', filename='uploads/' + filename), code=301)


@app.route('/articles')
def articles():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('SELECT * FROM public.articles ORDER BY article_id ASC')
    articles = cur.fetchall()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('SELECT count(*) FROM public.articles')
    number_of_articles = cur.fetchone()
    return render_template('articles.html', articles=articles, number_of_articles=number_of_articles)

    # User is not loggedin redirect to login page
    return redirect(url_for('login'))


@app.route('/articles/<article_id>')
def show_article_detail(article_id):
    """Display specific article details."""
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('SELECT * FROM public.articles WHERE article_id = %s', (article_id,))
    article = cur.fetchone()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.tags ORDER BY tag_id ASC")
    tags = cur.fetchall()

    return render_template("single-article.html",
                           article=article,
                           tags=tags,
                           )


@app.route('/delete-article', methods=['POST'])
def delete_article():
    """Deletes an article."""

    article_id = request.form.get('article-to-delete')
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('DELETE FROM public.articles WHERE article_id = %s', (article_id,))
    result

    return redirect('/articles')


################ TODO: check https://www.tutorialspoint.com/python_data_access/python_postgresql_update_table.htm for update code###################################################


@app.route('/outfits')
def outfits():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # Check if user is loggedin
    if 'loggedin' in session:
        cursor.execute('SELECT * FROM users WHERE id = %s', [session['id']])
        account = cursor.fetchone()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        result = cur.execute("SELECT * FROM public.outfits ORDER BY outfit_id ASC")
        outfits = cur.fetchall()
        return render_template('outfits.html', outfits=outfits)
    # User is not loggedin redirect to login page
    return redirect(url_for('login'))


@app.route('/add-outfit')
def show_create_outfit_form():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.tags ORDER BY tag_id ASC")
    tags = cur.fetchall()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.categories ORDER BY base_category_id ASC")
    categories = cur.fetchall()
    result = cur.execute('SELECT * FROM public.articles ORDER BY article_id ASC')
    articles = cur.fetchall()

    return render_template('add-outfit.html', categories=categories, tags=tags, articles=articles)


@app.route('/create-outfit', methods=['POST'])
def add_outfit():
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    description = request.form.get('outfit-description')
    name = request.form.get('outfit-name')
    article_ids = request.form.getlist('articles-to-add')
    cursor.execute(
        "INSERT INTO outfits (name, description, times_worn, id) VALUES (%s,%s,%s,"
        "%s)",
        (name, description, 0, 1))

    return redirect('/outfits')


@app.route('/outfits/<outfit_id>')
def show_outfit_detail(outfit_id):
    """Display specific outfit details."""
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.outfits WHERE outfit_id=%s", (outfit_id,))
    outfit = cur.fetchone()
    result = cur.execute("SELECT * FROM public.categories ORDER BY base_category_id ASC")
    categories = cur.fetchall()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.tags ORDER BY tag_id ASC")
    tags = cur.fetchall()

    return render_template('single-outfit.html',
                           outfit=outfit,
                           categories=categories,
                           tags=tags,
                           )


@app.route('/delete-outfit', methods=['POST'])
def delete_outfit():
    """Deletes an outfit."""

    outfit_id = request.form.get('outfit-to-delete')
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('DELETE FROM public.outfits WHERE outfit_id = %s', (outfit_id,))
    result

    return redirect('/outfits')


@app.route('/events')
def events():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.wear_events ORDER BY wear_event_id ASC")
    wear_events = cur.fetchall()
    return render_template('events.html', wear_events=wear_events)


@app.route('/add-event')
def show_create_event_form():
    """Display form to create a new wear event/clothing log."""
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.outfits ORDER BY outfit_id ASC")
    outfits = cur.fetchall()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.tags ORDER BY tag_id ASC")
    tags = cur.fetchall()
    return render_template('add-event.html',
                           CITIES=CITIES,
                           outfits=outfits,
                           tags=tags)


@app.route('/create-event', methods=['POST'])
def add_event():
    """Adds new event and redirects to the previous events page."""
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # String unpacking to pass as arguments to datetime
    year, month, day = request.form.get('event-date').split('-')
    time = request.form.get('event-time')
    city = request.form.get('city')
    description = request.form.get('event-description')
    name = request.form.get('event-name')
    outfit_id = request.form.get('event-outfit')
    tag_ids = request.form.getlist('event-tags')
    new_tag_string = request.form.get('new-tags')
    date_time = datetime(int(year), int(month), int(day), int(10))

    cursor.execute(
        'INSERT INTO public.wear_events(name, description, date, '
        ' id, outfit_id) VALUES( %s, %s, %s, %s, %s)',
        (name, description, date_time, 1, outfit_id))
    conn.commit()

    return redirect('/events')


@app.route('/events/<wear_event_id>')
def show_event_details(wear_event_id):
    """Display specific event details."""
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.tags ORDER BY tag_id ASC")
    tags = cur.fetchall()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('SELECT * FROM public.wear_events WHERE wear_event_id = %s', (wear_event_id,))
    event = cur.fetchone()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute("SELECT * FROM public.outfits ORDER BY outfit_id ASC")
    outfits = cur.fetchall()

    return render_template('single-event.html',
                           event=event,
                           tags=tags,
                           outfits=outfits,
                           )


@app.route('/delete-event', methods=['POST'])
def delete_event():
    """Deletes an event."""

    wear_event_id = request.form.get('event-to-delete')
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('DELETE FROM public.wear_events WHERE wear_event_id = %s', (wear_event_id,))
    result

    return redirect('/events')


@app.route('/update-tags', methods=['POST'])
def update_tags():
    name = request.form.get('new-tags')
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('UPDATE public.tags SET name = %S', (name,))
    result

    return redirect('/events')


@app.route('/update-event', methods=['GET', 'POST'])
def update_event():
    wear_event_id = request.form.get('event-to-edit')
    outfit_id = request.form.get('event-outfit-select')
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    result = cur.execute('UPDATE public.wear_events SET outfit_id=%s WHERE wear_event_id = %s', (outfit_id, wear_event_id))
    result

    return redirect('/events')


@app.route('/get-weather', methods=['POST', 'GET'])
def get_weather():
    city: str = request.form['name']
    mgr = owm.weather_manager()
    observation = mgr.weather_at_place(city)  # the observation object is a box containing a weather object
    weather = observation.weather
    weather.status  # short version of status (eg. 'Rain')
    weather.detailed_status
    temp_dict_celsius = weather.temperature('celsius')
    temp_dict_celsius['temp_min']
    temp_dict_celsius['temp_max']

    return render_template('get-weather.html', CITIES=CITIES, weather=weather,
                           temp_dict_celsius=temp_dict_celsius)


if __name__ == "__main__":
    app.run(debug=True)
