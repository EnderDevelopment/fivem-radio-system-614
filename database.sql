CREATE TABLE IF NOT EXISTS radio_channels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    frequency FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS player_radio (
    player_id INT NOT NULL,
    channel_id INT NOT NULL,
    PRIMARY KEY (player_id),
    FOREIGN KEY (channel_id) REFERENCES radio_channels(id)
);

INSERT INTO radio_channels (name, frequency) VALUES ('Channel 1', 1.0);
INSERT INTO radio_channels (name, frequency) VALUES ('Channel 2', 2.0);
INSERT INTO radio_channels (name, frequency) VALUES ('Channel 3', 3.0);