<template>
  <section v-if="bookInfo">
    <add-book-form ref="addBookForm" />
    <add-book-mark-form ref="addBookMarkForm" />
    <delete-book-dialog ref="deleteBookDialog" />
    <v-container class="px-lg-6 px-xl-16">
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
        <state-select
          class="ml-4"
          :selectedState="bookInfo.stateId"
          :bookInfoId="bookInfo.bookInfoId"
        />
        <v-spacer></v-spacer>
        <div>
          <v-btn class="ml-4" color="#16a085" @click="refreshBookInfo" dark>
            Refresh
            <v-icon right>mdi-refresh</v-icon>
          </v-btn>
          <v-btn class="ml-4" color="secondary" @click="updateBookDialog">
            Update
            <v-icon right>mdi-pen</v-icon>
          </v-btn>
          <v-btn class="ml-4" color="primary" @click="deleteBookDialog">
            Delete
            <v-icon right>mdi-delete</v-icon>
          </v-btn>
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
              * Pages: {{ bookInfo.vpageCount }}
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
            {{ bookInfo.description ? bookInfo.description : "..." }}
          </div>
        </v-col>
        <v-col cols="2" class="d-flex justify-end pt-4">
          <v-img :src="getImage" contain max-height="220" aspect-ratio="1.4">
          </v-img>
        </v-col>
      </v-row>
      <v-divider class="my-2 mb-6"></v-divider>
      <div class="d-flex align-end">
        <h1 class="ma-0">Bookmarks</h1>
        <v-spacer></v-spacer>
        <div>
          <v-btn class="ml-4" color="info" @click="addNewNote" dark>
            Add new bookmark
            <v-icon right>mdi-plus</v-icon>
          </v-btn>
        </div>
      </div>
      <book-mark-list class="mt-6" />
    </v-container>
  </section>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import AddBookForm from "../components/Book/AddBookForm.vue";
import BookMarkList from "../components/BookMark/BookMarkList.vue";
import DeleteBookDialog from "../components/Book/DeleteBookDialog.vue";
import AddBookMarkForm from "../components/BookMark/AddBookMarkForm.vue";
import StateSelect from "../components/State/StateSelect.vue";
export default {
  name: "Book",
  components: {
    AddBookForm,
    DeleteBookDialog,
    AddBookMarkForm,
    BookMarkList,
    StateSelect,
  },
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
    if (!this.bookInfo) this.$router.push({ name: "Books" });
    else {
      if (this.getBookInfo.bookInfoId) {
        this.bindBookMarks({ bookInfoId: this.getBookInfo.bookInfoId });
      }
    }
  },
  methods: {
    ...mapActions("book", ["updateScore"]),
    ...mapActions("bookMark", ["bindBookMarks"]),

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

    addNewNote() {
      this.$refs.addBookMarkForm.dialog = true;
      this.$refs.addBookMarkForm.bookInfoId = this.bookInfo.bookInfoId;
      console.log(this.bookInfo.pageCount);
      this.$refs.addBookMarkForm.maxPage = this.bookInfo.pageCount;
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