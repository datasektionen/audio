var SongListItem = React.createClass({
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

var SongList = React.createClass({
  render: function() {
    var songs = this.props.songs.map(function(song) {
      return (
        <SongListItem
          key={song.songid}
          songid={song.songid}
          songtitle={song.songtitle}
          checked={this.props.selected.indexOf(song.songid) != -1} // TODO: this is kinda ugly
          onClick={this.props.onSongClick}
          onSelectedChange={this.props.onSelectedChange} />
      );
    }.bind(this));
    var largewidth = this.props.currentsong ? "l7 pull-l5" : "l12"
    return (
      <div className={"collection col s12 " + largewidth}>
        {songs}
      </div>
    );
  }
});

var Song = React.createClass({
  componentDidUpdate: function() {
    if(window.scrollY > 300) {
      window.scrollTo(0, 160);
    }
  },
  render: function() {
    if(this.props.currentsong != false) {
      var song = this.props.currentsong;
      return (
        <div className="col s12 l5 push-l7" style={styles.song}>
          <a href="#" style={styles.close}>
            <i className="material-icons"  onClick={this.props.onClose}>add</i>
          </a>
          <h3 style={styles.songtitle} dangerouslySetInnerHTML={{__html: song.songtitle}}></h3>
          <p style={styles.songmeta} dangerouslySetInnerHTML={{__html: song.songmeta}}></p>
          <p style={styles.songtext} dangerouslySetInnerHTML={{__html: song.songtext}}></p>
          <p style={styles.songmeta} dangerouslySetInnerHTML={{__html: song.songnotes}}></p>
        </div>
      );
    }
    else return false;
  }
});

var AudioApp = React.createClass({
  fuse: {},
  getInitialState: function() {
    return {currentsong: false, songs: [], selected: []};
  },
  componentDidMount: function() {
    $.getJSON("/songs", function(data){
      var options = {
        caseSensitive: false,
        includeScore: false,
        shouldSort: true,
        threshold: 0.6,
        location: 0,
        distance: 50,
        maxPatternLength: 32,
        keys: ["songtitle","firstline"]
      };
      this.fuse = new Fuse(data.songs, options);
      this.setState({songs: this.fuse.list});
      this.setState({currentsong: this.getSong(location.hash.substr(1))})
    }.bind(this));
    window.addEventListener("hashchange", function() {
      this.setState({currentsong: this.getSong(location.hash.substr(1))})
    }.bind(this));
  },
  handleSelectedChange: function(checked, songid) {
    var newselected;
    if(checked) newselected = this.state.selected.concat([songid]);
    else        newselected = this.state.selected.filter(item => item != songid);
    this.setState({selected: newselected})

    var link = "songs.pdf?songids=" + Array.from(newselected);
    this.refs.PDFLink.href = link;
  },
  handleSongClick: function(songid) {
    this.setState({currentsong: this.getSong(songid)});
  },
  handleSongOverlayClose: function() {
    this.setState({currentsong: false});
    location.hash = "";
  },
  handleSearchChange: function(e) {
    if(e.target.value.length > 0) this.setState({songs: this.search(e.target.value)});
    else                          this.setState({songs: this.fuse.list});
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var topsong = this.state.songs[0];
    this.setState({currentsong: topsong});
    location.hash = topsong.songid;
  },
  search: function(searchstring) {
    if(searchstring.length > 0) return this.fuse.search(searchstring);
    else                        return this.fuse.list;
  },
  getSong: function(songid) {
    songid = parseInt(songid);
    var filter = this.fuse.list.filter(song => song.songid === songid) // TODO: this is really ugly
    if(filter.length > 0)
      return filter[0];
    else
      return false;
  },
  render: function() {
    var disabled = this.state.selected.length < 1 ? " disabled" : "";
    return (
      <div>
        <div style={styles.header} className="valign-wrapper deep-orange lighten-1">
          <div style={styles.centered}>
            <h3 className="valign" style={styles.headertext}>/dev/audio</h3>
            <a ref="PDFLink" target="_blank"
               style={styles.mainbutton}
               className={"btn deep-orange darken-1" + disabled}>
              PDF
            </a>
          </div>
        </div>
        <form onSubmit={this.handleSubmit} style={styles.centered}>
          <input
            style={styles.searchbar}
            type="text"
            autoFocus
            placeholder="Song title or firstline"
            onChange={this.handleSearchChange} />
        </form>
        <div className="row" style={styles.centered}>
          <Song
            currentsong={this.state.currentsong}
            onClose={this.handleSongOverlayClose} />
          <SongList
            songs={this.state.songs}
            selected={this.state.selected}
            currentsong={this.state.currentsong != false}
            onSongClick={this.handleSongClick}
            onSelectedChange={this.handleSelectedChange} />
        </div>
      </div>
    );
  }
});

ReactDOM.render(
  <AudioApp />,
  document.getElementById("wrapper")
);
