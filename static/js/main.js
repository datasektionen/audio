"use strict";

var SongListItem = React.createClass({
  displayName: "SongListItem",

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
      return React.createElement(SongListItem, {
        key: song.songid,
        songid: song.songid,
        songtitle: song.songtitle,
        checked: this.props.selected.indexOf(song.songid) != -1 // TODO: this is kinda ugly
        , onClick: this.props.onSongClick,
        onSelectedChange: this.props.onSelectedChange });
    }).bind(this));
    var largewidth = this.props.currentsong ? "l7 pull-l5" : "l12";
    return React.createElement(
      "div",
      { className: "collection col s12 " + largewidth },
      songs
    );
  }
});

var Song = React.createClass({
  displayName: "Song",

  componentDidUpdate: function componentDidUpdate() {
    if (window.scrollY > 300) {
      window.scrollTo(0, 160);
    }
  },
  render: function render() {
    if (this.props.currentsong != false) {
      var song = this.props.currentsong;
      return React.createElement(
        "div",
        { className: "col s12 l5 push-l7", style: styles.song },
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

var AudioApp = React.createClass({
  displayName: "AudioApp",

  fuse: {},
  getInitialState: function getInitialState() {
    return { currentsong: false, songs: [], selected: [] };
  },
  componentDidMount: function componentDidMount() {
    $.getJSON("/songs", (function (data) {
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
      this.setState({ songs: this.fuse.list });
      this.setState({ currentsong: this.getSong(location.hash.substr(1)) });
    }).bind(this));
    window.addEventListener("hashchange", (function () {
      this.setState({ currentsong: this.getSong(location.hash.substr(1)) });
    }).bind(this));
  },
  handleSelectedChange: function handleSelectedChange(checked, songid) {
    var newselected;
    if (checked) newselected = this.state.selected.concat([songid]);else newselected = this.state.selected.filter(function (item) {
      return item != songid;
    });
    this.setState({ selected: newselected });

    var link = "songs.pdf?songids=" + Array.from(newselected);
    this.refs.PDFLink.href = link;
  },
  handleSongClick: function handleSongClick(songid) {
    this.setState({ currentsong: this.getSong(songid) });
  },
  handleSongOverlayClose: function handleSongOverlayClose() {
    this.setState({ currentsong: false });
    location.hash = "";
  },
  handleSearchChange: function handleSearchChange(e) {
    if (e.target.value.length > 0) this.setState({ songs: this.search(e.target.value) });else this.setState({ songs: this.fuse.list });
  },
  handleSubmit: function handleSubmit(e) {
    e.preventDefault();
    var topsong = this.state.songs[0];
    this.setState({ currentsong: topsong });
    location.hash = topsong.songid;
  },
  search: function search(searchstring) {
    if (searchstring.length > 0) return this.fuse.search(searchstring);else return this.fuse.list;
  },
  getSong: function getSong(songid) {
    songid = parseInt(songid);
    var filter = this.fuse.list.filter(function (song) {
      return song.songid === songid;
    }); // TODO: this is really ugly
    if (filter.length > 0) return filter[0];else return false;
  },
  render: function render() {
    var disabled = this.state.selected.length < 1 ? " disabled" : "";
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
              className: "btn deep-orange darken-1" + disabled },
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
        { className: "row", style: styles.centered },
        React.createElement(Song, {
          currentsong: this.state.currentsong,
          onClose: this.handleSongOverlayClose }),
        React.createElement(SongList, {
          songs: this.state.songs,
          selected: this.state.selected,
          currentsong: this.state.currentsong != false,
          onSongClick: this.handleSongClick,
          onSelectedChange: this.handleSelectedChange })
      )
    );
  }
});

ReactDOM.render(React.createElement(AudioApp, null), document.getElementById("wrapper"));