<template>
  <section v-if="bookInfo">
    <add-book-form ref="addBookForm" />
    <delete-book-dialog ref="deleteBookDialog" />
    <v-container class="pt-12 px-lg-6 px-xl-16">
      <h1 class="mb-2">
        {{ bookInfo.name }} -
        {{ bookInfo.authorNames }}
        ( {{ bookInfo.vpublishYear }} )
      </h1>
      <div class="d-flex align-end mb-6">
        <v-rating
          background-color="secondary"
          color="secondary"
          hover
          v-model="bookInfo.score"
        >
        </v-rating>
        <v-spacer></v-spacer>
        <div>
          <v-btn class="ml-4" color="#16a085" @click="refreshBookInfo" dark
            >Refresh<v-icon right>mdi-refresh</v-icon></v-btn
          >
          <v-btn class="ml-4" color="secondary" @click="updateBookDialog"
            >Update <v-icon right>mdi-pen</v-icon></v-btn
          >
          <v-btn class="ml-4" color="primary" @click="deleteBookDialog"
            >Delete<v-icon right>mdi-delete</v-icon></v-btn
          >
        </div>
      </div>
      <v-row>
        <v-col cols="3" class="py-6">
          <div style="color: #16a085">
            <div class="google-sans-regular" v-if="bookInfo.translatorId">
              * Translated by {{ bookInfo.translatorName }}
            </div>
            <div class="google-sans-regular">
              * Published by {{ bookInfo.publisherName }}
            </div>
            <div class="google-sans-regular">
              * Category {{ bookInfo.categoryName }}
            </div>
          </div>
          <div class="pr-6">
            <v-divider class="my-2"></v-divider>
          </div>
          <div class="secondary--text">
            <div class="google-sans-regular">
              * Pages: {{ bookInfo.pageCount }}
            </div>
            <div class="google-sans-regular">
              * Dimensions: {{ bookInfo.dimensions }}
            </div>
            <div class="google-sans-regular">
              * Language: {{ bookInfo.languageName }}
            </div>
            <div v-if="bookInfo.edition" class="google-sans-regular">
              * Edition: {{ bookInfo.vedition }}
            </div>
          </div>
        </v-col>
        <v-col cols="7" class="pt-4">
          <h4><i>Description</i></h4>
          <div class="google-sans-regular font-italic">
            {{ bookInfo.description }}
          </div>
        </v-col>
        <v-col cols="2" class="d-flex justify-end pt-4">
          <v-img :src="getImage" contain max-height="220" aspect-ratio="1.4">
          </v-img>
        </v-col>
      </v-row>
      <v-divider class="my-2 mb-6"></v-divider>
    </v-container>
  </section>
</template>

<script>
import { mapActions } from "vuex";
import { mapGetters } from "vuex";
import AddBookForm from "../components/Book/AddBookForm.vue";
import DeleteBookDialog from "../components/Book/DeleteBookDialog.vue";
export default {
  name: "Book",
  components: { AddBookForm, DeleteBookDialog },
  data() {
    return {
      bookInfo: null,
    };
  },
  watch: {
    bookInfo(newVal, oldVal) {
      if (newVal && oldVal && newVal.score !== oldVal.score && newVal.score) {
        this.updateScore({
          bookInfoId: this.bookInfo.bookInfoId,
          score: newVal,
        });
      }
    },
    getBookInfos(newVal) {
      if (newVal) {
        this.bookInfo = this.getBookInfos.find(
          (x) => x.bookInfoId === this.bookInfo.bookInfoId
        );
      }
    },
  },
  mounted() {
    this.bookInfo = this.getBookInfo;
  },
  methods: {
    ...mapActions("book", ["updateScore"]),
    updateBookDialog() {
      this.$refs.addBookForm.dialog = true;
      this.$refs.addBookForm.bookInfo = this.bookInfo;
    },

    refreshBookInfo() {
      this.bookInfo = this.getBookInfos.find(
        (x) => x.bookInfoId === this.bookInfo.bookInfoId
      );
    },

    deleteBookDialog() {
      this.$refs.deleteBookDialog.dialog = true;
      this.$refs.deleteBookDialog.name = this.bookInfo.name;
      this.$refs.deleteBookDialog.bookInfoId = this.bookInfo.bookInfoId;
    },
  },
  computed: {
    ...mapGetters("book", ["getBookInfo", "getBookInfos"]),
    getImage() {
      try {
        return require(`@/assets/upload/img/${this.bookInfo.vimage}`);
      } catch (err) {
        return require("@/assets/upload/img/book/default_book_cover.jpg");
      }
    },
  },
};
</script>

<style scoped>
.v-application ul,
.v-application ol {
  padding: 0;
}

h1,
h4 {
  font-family: "Roboto", "Arial", sans-serif;
}
</style>