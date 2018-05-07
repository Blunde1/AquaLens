from flask import Flask, render_template, jsonify, request

import random
app = Flask(__name__)

TRESHOLD = 0.1
B = 10000


def calculate_stuff(csv_data):
    csv_data = [int(x.strip()) for x in csv_data.strip().split('\n')[1::]]
    number_of_observations = len(csv_data)
    mean_lice = sum(csv_data)/number_of_observations
    print("antall lus: {}".format(mean_lice))
    mean_lice_bootstrap = []

    need_to_fetch_more = False

    for i in range(B):
        sample = [random.choice(csv_data) for _ in csv_data]
        mean_lice_bootstrap.append(sum(sample)/len(sample))

    over_treshold = len([x for x in mean_lice_bootstrap if x >= 0.5])
    confidence = over_treshold/B
    print(confidence)

    if confidence >= TRESHOLD:
        need_to_fetch_more = True

    return {"plot": mean_lice_bootstrap, "advice": need_to_fetch_more}


@app.route('/')
def hello_world():
    return render_template("index.html")


@app.route('/result', methods=['POST', 'GET'])
def result():
    if request.method == 'POST':
        csv_data = request.form['input']
        output = calculate_stuff(csv_data)
        return render_template("result.html", data=output['plot'], advice=output['advice'])


if __name__ == '__main__':
    app.run(debug=True)
