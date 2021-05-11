<template>
  <v-select
    v-model="selected"
    :items="getStateValues"
    dense
    outlined
    hide-details
    style="max-width: 170px"
  ></v-select>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
export default {
  name: "StateSelect",
  data() {
    return {
      selected: null,
    };
  },
  props: {
    selectedState: {
      type: Number,
    },
    bookInfoId: {
      type: Number,
      required: true,
    },
  },

  watch: {
    selected(val, oldVal) {
      if (oldVal) {
        if (val) {
          let stateId = null;
          if (val !== "Not defined") {
            stateId = Object.keys(this.getStatesObject).find(
              (key) => this.getStatesObject[key] === this.selected
            );
          }
          this.updateState({ bookInfoId: this.bookInfoId, stateId });
        }
      }
    },
  },

  created() {
    if (this.selectedState) {
      this.selected = this.getStatesObject[this.selectedState];
    } else {
      this.selected = "Not defined";
    }
  },

  computed: {
    ...mapGetters("state", ["getStatesObject"]),
    getStateValues() {
      const values = Object.values(this.getStatesObject);
      values.unshift("Not defined");
      return values;
    },
  },
  methods: {
    ...mapActions("book", ["updateState"]),
  },
};
</script>

<style>
</style>