"use strict";

var Song = React.createClass({
  displayName: "Song",

  handleCheckboxClick: function handleCheckboxClick(e) {
    this.props.onSelectedChange(e.target.checked, this.props.songid);
  },
  handleSongClick: function handleSongClick(e) {
    this.props.onClick(this.props.songid);
  },
  render: function render() {
    return React.createElement(
      "div",
      { className: "collection-item" },
      React.createElement(
        "a",
        { href: "#" + this.props.songid, onClick: this.handleSongClick },
        this.props.songtitle
      ),
      React.createElement(
        "div",
        { style: styles.checkbox },
        React.createElement("input", {
          type: "checkbox",
          id: "song" + this.props.songid,
          defaultChecked: this.props.checked,
          onChange: this.handleCheckboxClick }),
        React.createElement("label", { htmlFor: "song" + this.props.songid })
      )
    );
  }
});

var SongList = React.createClass({
  displayName: "SongList",

  render: function render() {
    var songs = this.props.songs.map((function (song) {
      return React.createElement(Song, {
        key: song.songid,
        songid: song.songid,
        songtitle: song.songtitle,
        checked: this.props.selected.indexOf(song.songid) != -1 // TODO: this is kinda ugly
        , onClick: this.props.onSongClick,
        onSelectedChange: this.props.onSelectedChange });
    }).bind(this));
    return React.createElement(
      "div",
      { className: "collection" },
      songs
    );
  }
});

var SongOverlay = React.createClass({
  displayName: "SongOverlay",

  render: function render() {
    var _this = this;

    if (this.props.allSongs.hasOwnProperty(this.props.currentsong)) {
      var song = this.props.allSongs.filter(function (song) {
        return song.songid == _this.props.currentsong;
      })[0]; // TODO: this is really ugly
      return React.createElement(
        "div",
        { id: "overlay", style: styles.songoverlay },
        React.createElement(
          "a",
          { href: "#", style: styles.close },
          React.createElement(
            "i",
            { className: "material-icons", onClick: this.props.onClose },
            "add"
          )
        ),
        React.createElement("h3", { style: styles.songtitle, dangerouslySetInnerHTML: { __html: song.songtitle } }),
        React.createElement("p", { style: styles.songmeta, dangerouslySetInnerHTML: { __html: song.songmeta } }),
        React.createElement("p", { style: styles.songtext, dangerouslySetInnerHTML: { __html: song.songtext } }),
        React.createElement("p", { style: styles.songmeta, dangerouslySetInnerHTML: { __html: song.songnotes } })
      );
    } else return false;
  }
});

var SearchApp = React.createClass({
  displayName: "SearchApp",

  allSongs: [],
  fuse: {},
  getInitialState: function getInitialState() {
    return { searchstring: '', currentsong: location.hash.substr(1), songs: [], selected: [] };
  },
  componentDidMount: function componentDidMount() {
    $.getJSON('/songs', (function (data) {
      var options = {
        caseSensitive: false,
        includeScore: false,
        shouldSort: true,
        threshold: 0.6,
        location: 0,
        distance: 50,
        maxPatternLength: 32,
        keys: ["songtitle", "firstline"]
      };
      this.fuse = new Fuse(data.songs, options);
      this.allSongs = data.songs;
      this.setState({ songs: this.search() });
    }).bind(this));
    window.addEventListener("hashchange", (function () {
      this.setState({ currentsong: location.hash.substr(1) });
    }).bind(this));
  },
  handleSelectedChange: function handleSelectedChange(checked, songid) {
    var newstate;
    if (checked) newstate = this.state.selected.concat([songid]);else newstate = this.state.selected.filter(function (item) {
      return item != songid;
    });
    this.setState({ selected: newstate });

    var link = 'songs.pdf?songids=' + Array.from(newstate);
    this.refs.PDFLink.href = link;
  },
  handleSongClick: function handleSongClick(songid) {
    this.setState({ currentsong: songid });
  },
  handleSongOverlayClose: function handleSongOverlayClose() {
    this.setState({ currentsong: false });
    location.hash = '';
  },
  handleSearchChange: function handleSearchChange(e) {
    if (e.target.value.length > 0) this.setState({ searchstring: e.target.value, songs: this.search() });else this.setState({ searchstring: "", songs: this.fuse.list });
  },
  handleSubmit: function handleSubmit(e) {
    e.preventDefault();
    var topsongid = this.state.songs[0].songid;
    this.setState({ currentsong: topsongid });
    location.hash = topsongid;
  },
  search: function search() {
    if (this.state.searchstring.length > 0) return this.fuse.search(this.state.searchstring);else return this.fuse.list;
  },
  render: function render() {
    var disabled = this.state.selected.length < 1 ? ' disabled' : '';
    return React.createElement(
      "div",
      null,
      React.createElement(
        "div",
        { style: styles.header, className: "valign-wrapper deep-orange lighten-1" },
        React.createElement(
          "div",
          { style: styles.centered },
          React.createElement(
            "h3",
            { className: "valign", style: styles.headertext },
            "/dev/audio"
          ),
          React.createElement(
            "a",
            { ref: "PDFLink", target: "_blank",
              style: styles.mainbutton,
              className: "btn deep-orange" + disabled },
            "PDF"
          )
        )
      ),
      React.createElement(
        "form",
        { onSubmit: this.handleSubmit, style: styles.centered },
        React.createElement("input", {
          style: styles.searchbar,
          type: "text",
          autoFocus: true,
          placeholder: "Song title or firstline",
          onChange: this.handleSearchChange })
      ),
      React.createElement(
        "div",
        { style: styles.centered },
        React.createElement(SongList, {
          songs: this.state.songs,
          selected: this.state.selected,
          onSongClick: this.handleSongClick,
          onSelectedChange: this.handleSelectedChange }),
        React.createElement(SongOverlay, {
          allSongs: this.allSongs,
          currentsong: this.state.currentsong,
          onClose: this.handleSongOverlayClose })
      )
    );
  }
});

ReactDOM.render(React.createElement(SearchApp, null), document.getElementById("wrapper"));