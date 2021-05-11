<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" width="500" persistent>
      <v-card style="cursor: initial">
        <v-toolbar elevation="1" color="secondary" dark>
          <v-toolbar-title class="google-sans-regular"
            >Add new bookmark</v-toolbar-title
          >
          <v-spacer></v-spacer>
          <v-btn @click="dialog = false" icon>
            <v-icon>mdi-close</v-icon></v-btn
          >
        </v-toolbar>
        <v-card-text class="pb-0">
          <v-form class="pt-4" ref="form" v-model="valid" lazy-validation>
            <span class="subheader">Page</span>
            <v-row>
              <v-col>
                <v-slider
                  v-model="page"
                  class="align-center"
                  min="0"
                  :max="maxPage ? maxPage : '1000000'"
                  hide-details
                >
                  <template v-slot:append>
                    <v-text-field
                      readonly
                      outlined
                      dense
                      v-model="page"
                      class="mt-0 pt-0"
                      :rules="pageRules"
                      single-line
                      type="number"
                      style="width: 80px"
                    ></v-text-field>
                  </template>
                </v-slider>
              </v-col>
            </v-row>
            <span class="subheader">Note</span>
            <v-row>
              <v-col>
                <v-textarea
                  rows="4"
                  color="secondary"
                  label="Note"
                  :rules="noteRules"
                  v-model="note"
                  no-resize
                  outlined
                  dense
                ></v-textarea>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="dialog = false"> Cancel </v-btn>
          <v-btn
            color="secondary"
            :disabled="!valid"
            text
            @click="_addBookMark"
          >
            Add new</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "AddBookMarkForm",
  data() {
    return {
      dialog: false,
      loading: false,
      page: null,
      note: null,
      valid: true,
      maxPage: null,
      bookInfoId: null,

      noteRules: [
        (v) =>
          !v ||
          v.length < 4000 ||
          "Description can't be longer than 4000 charachter",
      ],
      pageRules: [
        (v) => !v || (v >= 0 && /^\d*$/.test(v)) || "invalid",
        (v) => !v || !this.maxPage || v <= this.maxPage || "max",
      ],
    };
  },

  props: {
    bookMark: {
      type: Object,
    },
  },

  watch: {
    dialog: function (newValue) {
      if (!newValue) {
        this.page = null;
        this.note = null;
        this.resetValidation();
      }
    },
  },

  methods: {
    ...mapActions("bookMark", ["addBookMark"]),
    async _addBookMark() {
      try {
        this.loading = false;
        this.validate();
        await this.addBookMark({
          bookInfoId: this.bookInfoId,
          note: this.note,
          page: parseInt(this.page),
        });
        this.dialog = false;
      } catch (err) {
        console.error(err);
      }
      this.loading = true;
    },
    validate() {
      this.$refs.form.validate();
    },
    resetValidation() {
      this.$refs.form.resetValidation();
    },
  },
};
</script>

<style>
.v-application--is-ltr textarea::-webkit-scrollbar {
  display: none;
}
</style>