<template>
  <v-stepper-content step="1" class="pa-2 pb-0">
    <v-form ref="form" v-model="valid">
      <span class="subheader">Name & Language</span>
      <v-row>
        <v-col cols="6">
          <v-text-field
            v-model="name"
            :rules="nameRules"
            color="secondary"
            label="Book's name*"
            outlined
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="6">
          <v-select
            :items="getLanguageNames"
            v-model="language"
            color="secondary"
            label="Language"
            outlined
            dense
          ></v-select>
        </v-col>
      </v-row>
      <span class="subheader">Publish year & Edition & Pages</span>
      <v-row>
        <v-col cols="4">
          <v-text-field
            v-model="publishYear"
            :rules="publishYearRules"
            color="secondary"
            label="Publish Year"
            outlined
            dense
          ></v-text-field>
        </v-col>

        <v-col cols="4">
          <v-text-field
            v-model="edition"
            :rules="editionRules"
            color="secondary"
            label="Edition"
            outlined
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="4">
          <v-text-field
            v-model="pageCount"
            :rules="pageCountRules"
            color="secondary"
            label="Pages Count"
            outlined
            dense
          ></v-text-field>
        </v-col>
      </v-row>
      <span class="subheader">Description</span>
      <v-row>
        <v-col>
          <v-textarea
            rows="3"
            :rules="descriptionRules"
            v-model="description"
            color="secondary"
            label="Description"
            no-resize
            outlined
            dense
          ></v-textarea>
        </v-col>
      </v-row>

      <span class="subheader">Dimensions & Cover image</span>
      <v-row class="pb-0 mb-0">
        <v-col cols="6" class="d-flex justify-end pb-0 mb-0">
          <v-text-field
            v-model="width"
            :rules="widthRules"
            color="secondary"
            dense
            outlined
            label="Width"
          ></v-text-field>
          <v-text-field
            v-model="height"
            :rules="heightRules"
            color="secondary"
            dense
            outlined
            label="Height"
          ></v-text-field>
        </v-col>
        <v-col cols="6" class="pb-0 mb-0">
          <v-file-input
            @change="willImageUpdate = true"
            v-model="imageData"
            :rules="imageRules"
            outlined
            accept="image/jpg, image/jpeg"
            prepend-icon="mdi-image"
            label="Select an image"
            dense
            color="secondary"
          ></v-file-input>
        </v-col>
      </v-row>
    </v-form>
    <v-row class="ma-0 py-0">
      <v-spacer></v-spacer>
      <v-btn
        :loading="loading"
        :disabled="!valid"
        @click="_addOrUpdateBook()"
        depressed
        color="primary"
        >Next</v-btn
      >
    </v-row>
  </v-stepper-content>
</template>

<script>
import { mapActions } from "vuex";
import { mapGetters } from "vuex";
export default {
  name: "AddBookFormStep1",

  data() {
    return {
      name: null,
      publishYear: null,
      edition: null,
      pageCount: null,
      height: null,
      width: null,
      imageData: null,
      willImageUpdate: false,
      language: null,
      description: null,
      valid: false,
      loading: false,

      nameRules: [
        (v) => (!!v && v.length > 1) || "Name is required",
        (v) =>
          (!!v && v.length < 200) ||
          "Name can't have longer than 200 characters",
      ],
      publishYearRules: [
        (v) =>
          !v ||
          (v > 0 && v < 9999 && /^\d*$/.test(v)) ||
          "Invalid publish year",
      ],
      pageCountRules: [
        (v) => !v || (v > 5 && /^\d*$/.test(v)) || "Invalid pages count",
      ],
      editionRules: [
        (v) => !v || (v > 0 && /^\d*$/.test(v)) || "Invalid edition ",
      ],
      widthRules: [
        (v) => !v || v > 5 || /^[0-9]+(\.[0-9]+)+$/.test(v) || "Invalid width",
      ],
      heightRules: [
        (v) => !v || v > 5 || /^[0-9]+(\.[0-9]+)+$/.test(v) || "Invalid height",
      ],
      descriptionRules: [
        (v) =>
          !v ||
          v.length < 1000 ||
          "Description can't be longer than 1000 charachter",
      ],
      imageRules: [
        (v) => !v || v.size < 4000000 || "Image size should be less than 5 MB!",
      ],
    };
  },

  props: {
    bookInfo: {
      type: Object,
    },
  },

  created() {
    if (this.bookInfo) {
      this.name = this.bookInfo.name;
      this.language = this.bookInfo.languageName;
      this.publishYear = this.bookInfo.publishYear
        ? this.bookInfo.publishYear.substring(0, 4)
        : null;
      this.edition = this.bookInfo.edition;
      this.pageCount = this.bookInfo.pageCount;
      this.description = this.bookInfo.description;
      this.imageData = this.bookInfo.image
        ? new File([""], this.bookInfo.image)
        : null;
      this.width = this.bookInfo.width;
      this.height = this.bookInfo.height;
    }
  },

  computed: {
    ...mapGetters("language", ["getLanguageNames"]),
    ...mapGetters("language", ["getLanguageMap"]),
    ...mapGetters("book", ["getLastInsertedBookId"]),
  },

  methods: {
    ...mapActions("book", ["addOrUpdateBook"]),
    async _addOrUpdateBook() {
      try {
        this.loading = true;
        if (this.valid) {
          await this.addOrUpdateBook({
            bookInfoId: this.bookInfo ? this.bookInfo.bookInfoId : null,
            name: this.name,
            publishYear: this.publishYear,
            edition: this.edition,
            pageCount: this.pageCount,
            height: this.height,
            width: this.width,
            imageData: this.imageData,
            languageId: this.getLanguageMap[this.language],
            description: this.description,
          });

          this.$emit("nextStep");
        }
      } catch (err) {
        console.log(err);
      }
      this.loading = false;
    },

    resetForm() {
      this.$refs.form.reset();
    },

    validate() {
      this.$refs.form.validate();
    },
  },
};
</script>

<style scoped>
</style>