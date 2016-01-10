var styles = require('./styles.js')

module.exports = React.createClass({
  displayName: "SongListItem",
  handleCheckboxClick: function(e) {
    this.props.onSelectedChange(e.target.checked, this.props.songid);
  },
  handleSongClick: function(e) {
    this.props.onClick(this.props.songid);
  },
  render: function() {
    return (
      <div className="collection-item">
        <a href={"#" + this.props.songid} onClick={this.handleSongClick}>
          {this.props.songtitle}
        </a>
        <div style={styles.checkbox}>
            <input
              type="checkbox"
              id={"song" + this.props.songid}
              defaultChecked={this.props.checked}
              onChange={this.handleCheckboxClick} />
          <label htmlFor={"song" + this.props.songid} />
        </div>
      </div>
    );
  }
});
