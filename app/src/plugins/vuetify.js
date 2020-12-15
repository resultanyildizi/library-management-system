import Vue from "vue";
import Vuetify from "vuetify/lib";
// import colors from "vuetify/lib/util/colors";

const vuetify = new Vuetify({
  theme: {
    themes: {
      light: {
        primary: "#D45B5B",
        secondary: "#F8BF0F",
        accent: "#C4970B",
        error: "#b71c1c",
        background: "#b71c1c",
      },
    },
  },
});

Vue.use(Vuetify);

export default vuetify;
