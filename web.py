from requestbin import config, db
import os

from requestbin import app

if __name__ == "__main__":
    port = int(os.environ.get('PORT', config.PORT_NUMBER))

    for bin in config.PREDEFINED_BINS:
        db.create_bin(private=False, key=bin)

    app.run(host='0.0.0.0', port=port, debug=config.DEBUG)