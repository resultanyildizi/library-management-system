<template>
  <v-stepper-content step="2" class="pa-2 pb-0">
    <add-author-form ref="addAuthorForm" />
    <add-publisher-form ref="addPublisherForm" />
    <v-form ref="form">
      <v-row>
        <v-col cols="6">
          <span class="subheader">Select an author</span>
          <v-select
            :items="getAuthorNames"
            v-model="authorNames"
            color="secondary"
            label="Select an author"
            class="mt-2"
            outlined
            dense
            multiple
          >
            <template v-slot:selection="{ item, index }">
              <span v-if="index === 0" class="mr-2" style="font-size: 0.9rem">{{
                item
              }}</span>
              <span v-if="index === 1" class="grey--text caption">
                (+{{ authorNames.length - 1 }})
              </span>
            </template></v-select
          >
        </v-col>
        <v-col cols="6">
          <div class="subheader">In case you need</div>
          <v-btn class="mt-2" color="secondary" depressed @click="addAuthorForm"
            >Add new author</v-btn
          >
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="6">
          <span class="subheader">Select a translator if there is</span>
          <v-select
            :items="getAuthorNames"
            v-model="translatorName"
            color="secondary"
            label="Select a translator"
            class="mt-2"
            outlined
            dense
          ></v-select>
        </v-col>
        <v-col cols="6">
          <div class="subheader">In case you need</div>
          <v-btn class="mt-2" color="secondary" depressed @click="addAuthorForm"
            >Add new translator</v-btn
          >
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="6">
          <span class="subheader">Select a publisher</span>
          <v-select
            :items="getPublisherNames"
            v-model="publisherName"
            color="secondary"
            label="Select a publisher"
            outlined
            class="mt-2"
            dense
          ></v-select>
        </v-col>
        <v-col cols="6">
          <div class="subheader">In case you need</div>
          <v-btn
            class="mt-2"
            color="secondary"
            depressed
            @click="addPublisherForm"
            >Add new publisher</v-btn
          >
        </v-col>
      </v-row>
    </v-form>
    <v-row class="ma-0 py-0">
      <v-spacer></v-spacer>
      <v-btn class="mr-2" text @click="resetForm"> Reset </v-btn>
      <v-btn
        :loading="loading"
        @click="_updateAndInsert"
        depressed
        color="primary"
      >
        Next
      </v-btn>
    </v-row>
  </v-stepper-content>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import AddAuthorForm from "../Author/AddAuthorForm.vue";
import AddPublisherForm from "../Publisher/AddPublisherForm.vue";
export default {
  components: { AddAuthorForm, AddPublisherForm },
  name: "AddBookFormStep2",

  watch: {
    authorNames(val) {
      if (!val) this.authorIdList = null;
    },
    publisherName(val) {
      if (!val) this.publisherId = null;
    },
    translatorName(val) {
      if (!val) this.translatorId = null;
    },
  },
  data() {
    return {
      loading: false,
      authorIdList: [],
      authorNames: [],
      translatorName: null,
      translatorId: null,
      publisherName: null,
      publisherId: null,
    };
  },

  created() {},

  computed: {
    ...mapGetters("author", ["getAuthorsMap"]),
    ...mapGetters("publisher", ["getPublishersMap"]),
    ...mapGetters("book", ["getLastInsertedBookId"]),
    getAuthorNames() {
      return Object.values(this.getAuthorsMap);
    },
    getPublisherNames() {
      return Object.values(this.getPublishersMap);
    },
  },

  methods: {
    ...mapActions("book", ["updateAndInsert"]),
    async _updateAndInsert() {
      try {
        this.loading = true;
        if (this.publisherName) {
          this.publisherId = Object.keys(this.getPublishersMap).find(
            (key) => this.getPublishersMap[key] === this.publisherName
          );
        }
        if (this.translatorName) {
          this.translatorId = Object.keys(this.getAuthorsMap).find(
            (key) => this.getAuthorsMap[key] === this.translatorName
          );
        }

        var authorIdListString = null;
        if (this.authorNames && this.authorNames.length > 0) {
          this.authorNames.forEach((authorName) => {
            const authorId = Object.keys(this.getAuthorsMap).find(
              (key) => this.getAuthorsMap[key] === authorName
            );
            this.authorIdList.push(authorId);
          });
          console.log(this.authorIdList);

          authorIdListString = "[";

          this.authorIdList.forEach((authorId) => {
            authorIdListString += `${authorId}, `;
          });

          authorIdListString = authorIdListString.slice(0, -2);
          authorIdListString += "]";
        }

        await this.updateAndInsert({
          bookInfoId: this.getLastInsertedBookId,
          translatorId: this.translatorId,
          publisherId: this.publisherId,
          authorIdList: authorIdListString,
        });

        this.$emit("nextStep");
      } catch (err) {
        console.error(err);
      }
      this.loading = false;
    },

    resetForm() {
      this.$refs.form.reset();
    },

    addAuthorForm() {
      this.$refs.addAuthorForm.dialog = true;
    },

    addPublisherForm() {
      this.$refs.addPublisherForm.dialog = true;
    },
  },
};
</script>

<style scoped>
</style>